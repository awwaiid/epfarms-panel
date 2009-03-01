package EPFarms::Effin;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_classes;


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0wqPBBbg+MWxiSs4/Z3XUQ

our $AUTOLOAD;
sub AUTOLOAD {
  my $self = shift;
  my $method = substr($AUTOLOAD, rindex($AUTOLOAD, '::') + 2);
  return if $method eq 'DESTROY';
  return $self->resultset($method)->search(@_) if @_;
  return $self->resultset($method);
}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
