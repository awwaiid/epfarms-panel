package EPFarms::Panel::App;

use Moose;
extends qw( EPFarms::Panel::Base Continuity::Widget );

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

has 'panel'  => (is => 'ro');
has 'config' => (is => 'ro', default => sub {{
  rank => '50',
  name => '',
  title => '',
  icon => 'img/famfam/icons/house.png'
}});

sub display {
  my ($self, $content) = @_;
  return $self->next($content);
}

sub user_domains {
  my ($self) = @_;
  my $username = $self->panel->{user}->{username};
  my @domains = `ls /var/www/$username`;
  @domains = map { chomp ; $_ } @domains;
  @domains = grep { $_ !~ /
    ^(  back_to_home
      | public_html
      | tmp
      | web_logfiles
      | web_passwds
      | web_uploads
    )$/x
  } @domains;
  return @domains;
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

