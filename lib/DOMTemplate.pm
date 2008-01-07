
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


package HTML::Element;

sub elementify {
  return $_[0];
}

sub render {
  return $_[0]->as_HTML;
}

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
    my @nodes = $self->find_by_selector($key);
    foreach my $node (@nodes) {
      my $tag = $node->tag;
      if($tag eq 'input' || $tag eq 'option') {
        $node->attr(value => $attrs{$key});
      } else {
        $node->replace_content(to_node($attrs{$key}));
      }
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
  foreach my $key (keys %attrs) {
    my @nodes = $self->find_by_selector($key);
    foreach my $node (@nodes) {
      $node->attr(value => $attrs{$key});
    }
  }
}

sub set_value {
  my ($self, %attrs) = @_;
  use Data::Dumper;
  foreach my $key (keys %attrs) {
    $self->set_value_by_selector($key => $attrs{$key});
  }
}

sub to_node {
  my ($html) = @_;
  if(ref $html) {
    return $html;
  } else {
    #my $tree = DOMTemplate->new_from_content($html);
    my $tree = HTML::TreeBuilder->new_from_content($html);
    my @n = $tree->disembowel;
    return @n;
    #return HTML::Element->new('~literal','text' => $html);
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
  my ($self, @new_content) = @_;
  #$new_content = to_node($new_content);
  $self->delete_content();
  $self->push_content(@new_content);
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

  my $root = $self;

  # Clean the selector a bit
  $selector =~ s/\s+/ /g;

  # Split selector in to tokens
  my @tokens = split(/ /, $selector);
  my (@ok_nodes) = ();
  foreach my $token (@tokens) {
    while($token =~ /^(#|\.)?([-\w]+)/) {
      my $type = $1;
      my $name = $2;
      $token =~ s/^(#|\.)?([-\w]+)//; # Kill this part
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
          @ok_nodes = $root->look_down('id', $name);
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

sub fill_rows {
  my ($self, $selector, $data) = @_;
  my @nodes = $self->find_by_selector($selector);
  if(@nodes) {
    my $n = shift @nodes;
    my $rows =
      join "\n",
      map { "<tr>$_</tr>" }
        map {
          join "\n", map { "<td>$_</td>" } @$_
        } @$data
      ;
    $n->replace_content(to_node($rows));
  }
}



1;

