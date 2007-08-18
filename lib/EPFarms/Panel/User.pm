package EPFarms::Panel::User;

use strict;
use base 'EPFarms::Panel::Base';

=head1 NAME

EPFarms::Panel::User - Singleton object for the current user

=cut

sub username {
  my ($self) = @_;
  return $self->{username};
}

1;

