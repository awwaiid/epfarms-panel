package EPFarms::Panel;

use strict;
use base 'EPFarms::Panel::Base';

use lib '/home/awwaiid/projects/perl/domt';
use DOMTemplate;

our $VERSION = '2.01';

=head1 NAME

EPFarms::Panel - Panel application object for Eggplant Farms

=head1 SYNOPSIS

  use EPFarms::Panel;
  my $panel = EPFarms::Panel->new;
  $panel->shell;

=head1 DESCRIPTION

The Eggplant Farms panel is a primary access point for Eggplant Farms
account settings and information.

The panel itself is actually a manager for a pluggable collection of
specialized applications, All under the EPFarms::Panel::App namespace.

=head1 METHODS

=head2 C<< $panel = EPFarms::Panel->new(...) >>

Create a new instance of the panel. Each user gets their own instance, though
they might be viewing the instance with several views simultaneously.

=head2 C<< $panel->output($html) >>

Send a whole page of output to the browser.

TODO: Send and receive a RequestID, so that we can detect the 'back' button.

=cut

sub output {
  my ($self, $page) = @_;
  $self->{request}->print($page);
  $self->{request}->next;
}

=head2 C<< $panel->main >>

Main entrypoint of panel application. This does authentication and initializes
the list of modules. There is one instance of this loop running per-user
per-window.

=cut

our $auth;
sub main {
  my ($self) = @_;
  $auth = EPFarms::Panel::Auth->new unless $auth;
  my $user = $auth->get_authenticated_user;
  my $page = DOMTemplate->new('tpl/main.html');
  $page->set('username' => $user->username);
  $self->output($page->as_HTML);
}

=head1 SEE ALSO

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

