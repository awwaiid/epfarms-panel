
package EPFarms::Panel::App::UserProfile;

use strict;
use EPFarms::Panel::AppBase;
use base 'EPFarms::Panel::AppBase';

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=cut

sub new {
  my $class = shift;
  my $self = $class->SUPER::new(@_);

  $self->{panel}->add_sidebar_action(
    name => 'user_profile',
    title => 'User Profile',
    icon => 'img/famfam/icons/user.png',
    code => sub { $self->message("Hello Profile!") }
  ) if $self->{panel}{user}{username} eq 'awwaiid';

  return $self;
}

sub message {
  my ($self, $msg) = @_;
  print STDERR "MESSAGE: $msg\n";
}

=head1 SEE ALSO

L<EPFarms::Panel::App>
L<EPFarms::Panel>
L<http://community.epfarms.org/Panel_Documentation>

=head1 AUTHOR

Brock Wilcox, E<lt>awwaiid@epfarms.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Brock Wilcox

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;


