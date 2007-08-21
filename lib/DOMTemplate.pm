
package DOMTemplate;
use strict;
use base 'HTML::TreeBuilder';

sub new {
  my ($class, $filename, %attrs) = @_;
  $class = ref($class) || $class;
  my $self = $class->SUPER::new();
  bless $self, $class;

  if($filename) {
    $self->parse_file($filename);
    $self = $self->disembowel;
  }
  if(%attrs) {
    $self->set(%attrs);
  }
  return $self->elementify;
}

sub new_from_content {
  my ($class, $content, %attrs) = @_;
  $class = ref($class) || $class;
  my $self = $class->SUPER::new();
  bless $self, $class;

  if($content) {
    $self->parse($content);
    $self = $self->disembowel;
  }
  if(%attrs) {
    $self->set(%attrs);
  }
  return $self;
}


package HTML::Element;

sub apply {
  my ($self, $rules) = @_;
  while(@$rules) {
    my $rule = shift @$rules;
    my $code = shift @$rules;
    my @nodes = $self->find_by_selector($rule);
    foreach my $node (@nodes) {
      $code->($node);
    }
  }
}

sub add_class {
  my ($self, $class) = @_;
  my $cur_class = $self->attr('class');
  my %classes = map { $_ => 1 } split(/\s+/,$cur_class);
  $classes{$class} = 1;
  $cur_class = join(' ',keys %classes);
  $self->attr('class', $cur_class);
}

sub get_classes {
  my ($self) = @_;
  my $classes = $self->attr('class');
  my @classes = split /\s+/, $classes;
  return @classes;
}

# Shortcut to set by ID
sub set {
  my ($self, %attrs) = @_;
  foreach my $key (keys %attrs) {
    my @nodes = $self->find_by_selector("#$key");
    foreach my $node (@nodes) {
      $node->replace_content(to_node($attrs{$key}));
    }
  }
}

# Shortcut to get one by ID
sub get_id {
  my ($self, $id) = @_;
  my ($node) = $self->find_by_selector("#$id");
  return $node;
}

sub set_by_selector {
  my ($self, %attrs) = @_;
  foreach my $key (keys %attrs) {
    my @nodes = $self->find_by_selector($key);
    foreach my $node (@nodes) {
      $node->replace_content(to_node($attrs{$key}));
    }
  }
}

sub set_value_by_selector {
  my ($self, %attrs) = @_;
#  use Data::Dumper;
#  print STDERR "GAR2: " . Dumper(\%attrs) . "\n";
  foreach my $key (keys %attrs) {
    my @nodes = $self->find_by_selector($key);
#  print STDERR "nodes: " . Dumper(\@nodes) . "\n";
    foreach my $node (@nodes) {
      $node->attr(value => $attrs{$key});
#      print STDERR "SETTING value = $attrs{$key}\n";
    }
  }
}

sub set_value {
  my ($self, %attrs) = @_;
  use Data::Dumper;
#  print STDERR "GAR: " . Dumper(\%attrs) . "\n";
  foreach my $key (keys %attrs) {
    $self->set_value_by_selector("#$key" => $attrs{$key});
  }
}

sub to_node {
  my ($html) = @_;
  if(ref $html) {
    return $html;
  } else {
    return HTML::Element->new('~literal','text' => $html);
  }
}

sub replace_by_selector {
  my ($self, %attrs) = @_;
  foreach my $key (keys %attrs) {
    my @nodes = $self->find_by_selector($key);
    foreach my $node (@nodes) {
      $node->replace_with(to_node($attrs{$key}));
    }
  }
}

sub replace {
  my ($self, %attrs) = @_;
  foreach my $key (keys %attrs) {
    $self->replace_by_selector("#$key" => $attrs{$key});
  }
}

sub replace_content {
  my ($self, $new_content) = @_;
  $new_content = to_node($new_content);
  $self->delete_content();
  $self->push_content($new_content);
}

sub append_content {
  my ($self, $new_content) = @_;
  $new_content = to_node($new_content);
  $self->push_content($new_content);
}

sub prepend_content {
  my ($self, $new_content) = @_;
  $new_content = to_node($new_content);
  $self->unshift_content($new_content);
}


# Only supports a few things for now
sub find_by_selector {
  my ($self, $selector) = @_;
  #print STDERR "find_by_selector : $selector\n";

  my $root = $self;

  # Clean the selector a bit
  $selector =~ s/\s+/ /g;

  # Split selector in to tokens
  my @tokens = split(/ /, $selector);
  my (@ok_nodes) = ();
  foreach my $token (@tokens) {
    while($token =~ /^(#|\.)?(\w+)/) {
      my $type = $1;
      my $name = $2;
      $token =~ s/^(#|\.)?(\w+)//; # Kill this part
      #print STDERR "find_by_selector type: $type $name ($token)\n";
      if($type eq '') {
        # Tag
        if($root) {
          @ok_nodes = $root->find_by_tag_name($name);
          undef $root;
        } else {
          @ok_nodes = map { $_->find_by_tag_name($name) } @ok_nodes;
        }
      } elsif($type eq '#') {
        # ID
        if($root) {
          #print STDERR "ROOT: " . $root->as_HTML . "\n\n";
          @ok_nodes = $root->look_down('id', $name);
          #print STDERR "find_by_selector ok_nodes: @ok_nodes\n";
          undef $root;
        } else {
          @ok_nodes = map { $_->look_down('id', $name) } @ok_nodes;
        }
      } elsif($type eq '.') {
        # Class
        # ID
        if($root) {
          @ok_nodes = $root->look_down('class', qr/\b$name\b/);
          undef $root;
        } else {
          @ok_nodes = map { $_->look_down('class', qr/\b$name\b/) } @ok_nodes;
        }
      }
    }
  }
  #return wantarray ? @ok_nodes : ($ok_nodes[0]);
  return @ok_nodes;
}


1;
