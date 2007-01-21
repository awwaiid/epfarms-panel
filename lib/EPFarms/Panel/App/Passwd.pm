
package EPFarms::Panel::App::Passwd;

use strict;
use warnings; # XXX while in development

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=head2 C<< $panel->shell() >>

Start an interactive shell on the command line.

=cut

sub shell {
  my ($self) = @_;
}

=head2 C<< $panel->web($request) >>

Start an interactive web instance of the panel. Needs to be passed the
L<Continuity> request object.

=cut

sub web { }

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


