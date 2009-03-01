package EPFarms::Panel::User;

use Moose;
extends 'EPFarms::Panel::Base';

has auth_ok => ( is => 'rw' );
has 'has_javascript' => ( is => 'rw' );
has 'username' => ( is => 'rw' );
has 'password' => ( is => 'rw' );
has 'last_auth' => ( is => 'rw' );
has 'auth_token' => ( is => 'rw' );

=head1 NAME

EPFarms::Panel::User - Singleton object for the current user

=cut

1;

