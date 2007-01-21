package EPFarms::Panel;

use strict;
use warnings; # XXX while in development

our $VERSION = '2.01';

=head1 NAME

EPFarms::Panel - Panel application object for Eggplant Farms

=head1 SYNOPSIS

  use EPFarms::Panel;
  my $panel = EPFarms::Panel->new;
  $panel->shell;

=head1 DESCRIPTION

The Eggplant Farms panel is a primary access point for your Eggplant Farms
account settings and information. It has both a web interface and an
interactive shell.

The panel itself is actually a pluggable collection of specialized
applications, All under the EPFarms::Panel::App namespace.

=head1 METHODS

=head2 C<< $panel = EPFarms::Panel->new(...) >>

Create a new instance of the panel. Each user gets their own instance, though
they might be viewing the instance with several views simultaneously.

=cut

sub new {
  my ($class, %ops) = @_;
  my $self = { %ops };
  bless $self, $class;
  return $self;
}

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

