package EPFarms::Panel::User;

use strict;
use Moose;
extends 'EPFarms::Panel::Base';

has auth_ok => ( is => 'rw' );
has 'has_javascript' => ( is => 'rw' );
has 'username' => ( is => 'rw' );
has 'password' => ( is => 'rw' );

=head1 NAME

EPFarms::Panel::User - Singleton object for the current user

=cut

sub username {
  my ($self) = @_;
  return $self->{username};
}

1;

