package MooseX::Renderer::Continuity::HTML;

use Moose::Role;

sub render_attribute {
  my ($self, $name, $attribute) = @_;
  # print "Rendering $name...\n";
  # print "Order: " . $attribute->description->{order} . "\n";
  # print "Line: " . $attribute->definition_context->{line} . "\n";
  my $r = "$self";
  $r =~ s/^.*\(0x(\w+)\)$/$1/;
  #print "r: $r\n";
  my $html_name = "$r-$name";
  my $output = '';
  if($attribute->{is} eq 'ro') {
    $output = "$name: " . $self->$name;
    $output = "<div class=field>\n  <span class=label>" . $name . "</span>\n"
        . "  <span class=input>\n@{[ $self->$name ]} </span>\n"
        . "</div>\n";
  } elsif($attribute->has_type_constraint) {
    my $constraint = $attribute->type_constraint;
    # print "Constraint type: " . (ref $constraint) . "\n";
    # print "Type: " . $constraint->name . "\n";
    if(ref $constraint eq 'Moose::Meta::TypeConstraint::Enum') {
      my $val = $self->$name;
      $output = "  <select name="
        . $html_name
        . ">\n"
        . join('',map { "    <option" . (defined $val && $val eq $_ ? ' selected' : '') . ">$_</option>\n" } @{$constraint->values})
        . "  </select>\n";
    } elsif($constraint->is_a_type_of('ArrayRef')) {
      return '';
    } elsif($constraint->is_a_type_of('Str')) {
      $output = "  <input type=text name=\"$html_name\" value=\"" . ($self->$name || '') . "\">\n";
    } elsif($constraint->is_a_type_of('Num')) {
      $output = "  <input type=text name=\"$html_name\" value=\"" . $self->$name . "\">\n";
    } elsif($constraint->is_a_type_of('Bool')) {
      $output = "  <input type=checkbox name=\"$html_name\""
        . ($self->$name ? ' checked' : '')
        . ">\n";
    }

    my $label = $attribute->description->{label};
    if(!$label) {
      $label = $name;
      $label =~ s/_/ /g;
      $label =~ s/\b(\w)/\u$1/g;
    }
    $output = "<div class=field>\n  <span class=label>" . $label . "</span>\n"
        . "  <span class=input>\n$output  </span>\n"
        . "</div>\n";
  }
  return $output;
}

sub render {
  my ($self) = @_;
  my %attributes = %{ $self->meta->get_attribute_map };
  my $output = '';
  my @attributes = map { [$_ => $attributes{$_}] } keys %attributes;
  @attributes = map { $_->[1] }
    sort { $a->[0] <=> $b->[0] }
    map { [ $_->[1]->order, $_ ] }
    @attributes;
  #while ( my ( $name, $attribute ) = each %attributes ) {
  foreach my $attr (@attributes) {
    $output .= $self->render_attribute(@$attr);
  }
  return $output;
}

sub update_from_request {
  my ($self, $f) = @_;
  my %attributes = %{ $self->meta->get_attribute_map };
  my $r = "$self";
  $r =~ s/^.*\(0x(\w+)\)$/$1/;
  while ( my ( $name, $attribute ) = each %attributes ) {
    my $html_name = "$r-$name";
    if($self->render_attribute($name, $attribute) && $attribute->{is} eq 'rw') {
      if($attribute->has_type_constraint) {
        my $constraint = $attribute->type_constraint;
        if($constraint->is_a_type_of('Bool')) {
          $self->$name( $f->{$html_name} ? 1 : 0 );
        } else {
          $self->$name($f->{$html_name});
        }
      } else {
        $self->$name($f->{$html_name});
      }
      my $val = defined($f->{$html_name}) ? $f->{$html_name} : 'undef';
      print "Setting $name = $val\n";
    }
  }
}

1;

