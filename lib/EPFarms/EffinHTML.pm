package EPFarms::EffinHTML;

use Moose::Role;

sub html_fieldname {
  my ($self, $field) = @_;
  my $id = $self->id;
  my $tablename = $self->table;
  my $fieldname = "$tablename-$id-$field";
  return $fieldname;
}


sub html_text_input {
  my ($self, $field) = @_;
  my $fieldname = $self->html_fieldname($field);
  return qq|
    <input type=text name="$fieldname" id="$fieldname" value="@{[$self->$field]}">
  |;
}

sub html_checkbox {
  my ($self, $field, $vals) = @_;
  my $fieldname = $self->html_fieldname($field);
  my $checked = '';
  if($self->$field eq $vals->[1]) {
    $checked = 'checked';
  }
  return qq|
    <input type=checkbox name="$fieldname" id="$fieldname" $checked>
  |;
}

sub html_update_text {
  my ($self, $field, %params) = @_;
  my $fieldname = $self->html_fieldname($field);
  $self->$field( $params{$fieldname} );
}

sub html_update_checkbox {
  my ($self, $field, $vals, %params) = @_;
  my $fieldname = $self->html_fieldname($field);
  if($params{$fieldname}) {
    $self->$field( $vals->[1] );
  } else {
    $self->$field( $vals->[0] );
  }
}

1;

