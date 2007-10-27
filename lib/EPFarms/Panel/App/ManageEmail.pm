
package EPFarms::Panel::App::ManageEmail;

use strict;
use base 'EPFarms::Panel::AppBase';
use Net::SCP::Expect;
use File::Slurp;

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
    name => 'manage_email',
    title => 'Manage Email',
    icon => 'img/famfam/icons/email.png',
    code => sub { $self->main }
  ) if $self->{panel}{user}{username} eq 'awwaiid';

  return $self;
}

sub main {
  my ($self) = @_;
  my @domains = $self->user_domains;
  my $output;
  $output .= "<h2>Domains:</h2>";
  $output .= join '', map { "<li><a href='?domain=$_'>$_</a></li>" } @domains;
  $self->display( $output );
  my $domain = $self->param('domain');
  if($domain) {
    $output = "<h2>Domain: $domain</h2>";
    my $scp = Net::SCP::Expect->new( timeout => 30 );
    $scp->login($self->{panel}->{user}->{username}, $self->{panel}->{user}->{password});
    print STDERR "scp pointless.epfarms.org:/etc/exim4/dom-aliases/$domain /tmp/dom-alias-$domain\n";
    $scp->scp("pointless.epfarms.org:/etc/exim4/dom-aliases/$domain", "/tmp/dom-alias-$domain");
    print STDERR "Done with scp!\n";
    my $content = read_file("/tmp/dom-alias-$domain");
    $output .= "<hr>$content<hr>";
    $self->display($output);
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


