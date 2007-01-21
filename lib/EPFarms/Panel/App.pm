package EPFarms::Panel::App;

use 5.008008;
use strict;
use warnings;

our $VERSION = '2.01';

=head1 NAME

EPFarms::Panel::App - Base class for panel applications

=head1 SYNOPSIS

  use base 'EPFarms::Panel::App';

=head1 DESCRIPTION

This base class provides both a common API for the panel applications, and some
useful helpers.

There are generally two modes for an application. REST-mode, which is generally
state-less, and Continuity-mode, which is stateful.

=head1 METHODS

=head2 C<< $panel = EPFarms::Panel::App->new(...) >>

Create a new instance of the panel application. Each user gets their own instance, though
they might be viewing the instance with several views simultaneously.

=cut

sub new {
  my ($class, %ops) = @_;
  my $self = { %ops };
  bless $self, $class;
  return $self;
}

=head1 SEE ALSO

L<EPFarms::Panel>, L<http://community.epfarms.org/Panel_Documentation>

=head1 AUTHOR

Brock Wilcox, E<lt>awwaiid@epfarms.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Brock Wilcox

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;

