
package EPFarms::Panel::App::Home;

use Moose;
extends 'EPFarms::Panel::App';

has '+config' => (default => sub {{
  rank => '00',
  name => 'home',
  title => 'Panel Home',
  icon => 'img/famfam/icons/house.png'
}});

=head1 NAME

EPFarms::Panel::App::Home - Main page

=head1 DESCRIPTION

Main entry page of panel. For now just displays a static message, but in the
future will perhaps agregate several apps.

=head1 METHODS

=cut

sub main {
  my $self = shift;
  while(1) {
    $self->display(qq{
        <h2>EPFarms User Panel Home</h2>
        <p><b>(2008.03.31)</b>
        I just fixed the password changing tool so that it works again. I
        updated the server information to work with Nightshade (the new mail
        server), and made the script generally more robust.
        </p>
        <p><b>(2008.02.18)</b>
        We've made quite a few improvements since the last update. The payment
        system is working nicely, and we've added more advanced email
        management tools. The TODO list is too long to put here, but the
        biggest highlight is a domain management tool. This will allow you to
        register, add, and modify various aspects of your domains.
        </p>
        <p><b>(2007.09.23)</b> The user panel is being reborn! So please be
        patient with us while we grow it, as some of the things that are going
        into the panel are quite experimental. See the <a
        href="http://community.epfarms.org/User_Panel_Development">User Panel
        Development</a> page on the community wiki for development updates or to
        join in the fun.
        </p>
      });
  }
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


