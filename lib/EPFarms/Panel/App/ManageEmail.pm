
package EPFarms::Panel::App::ManageEmail;

use Moose;
extends 'EPFarms::Panel::App';

has '+config' => (default => sub {{
  rank => '30',
  name => 'manage_email',
  title => 'Manage Email',
  icon => 'img/famfam/icons/email.png',
}});

use Net::SCP::Expect;
use File::Slurp;

=head1 NAME

EPFarms::Panel::App::ManageEmail - Simple email settings management

=head1 DESCRIPTION

Allows users to edit their basic email settings.

=head1 METHODS

=cut

sub main {
  my ($self) = @_;
  my @domains = $self->user_domains;
  my $output = '';
  $output .= "<h2>Spamassassin Settings</h2>";
  $output .= '<a href="?op=spamassassin_advanced">Advanced Spamassassin Settings Editor</a><br>';
  $output .= "<h2>Domain Email Management</h2>";
  $output .= "<table><tr><th>Domain</th></tr>";
  $output .= join '', map { qq{
    <tr>
      <td>$_</td>
      <td><a href='?domain=$_&edit=alias'>Aliases</a></td>
      <td><a href='?domain=$_&edit=accounts'>Accounts</a></td>
    <!--  <td><a href='?domain=$_&edit=lists'>Lists</a></td> -->
    </tr>
  } } @domains;
  $output .= "</table>";
  $self->display( $output );
  my $domain = $self->param('domain');
  if($domain) {
    my $edit = $self->param('edit');
    if($edit eq 'alias') {
      $self->edit_remote_file('mail.epfarms.org', "/etc/exim4/dom-aliases/$domain");
    } elsif($edit eq 'accounts') {
      $self->edit_remote_file('mail.epfarms.org', "/etc/exim4/dom-accounts/$domain");
    }
  }
  if($self->param('op') eq 'spamassassin_advanced') {
    $self->edit_remote_file('mail.epfarms.org', "/home/$self->{panel}{user}{username}/.spamassassin/user_prefs");
  }
}

sub edit_remote_file {
  my ($self, $host, $file) = @_;
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};
  my $local_file = $file;
  $local_file =~ s/\//-/g;
  my $scp = Net::SCP::Expect->new(
    timeout => 30,
    option  => 'StrictHostKeyChecking=no',
  );
  $scp->login($username, $password);
  $scp->scp("$host:$file", "/home/$username/.epfarms-panel/tmp/$local_file");
  my $content = read_file("/home/$username/.epfarms-panel/tmp/$local_file");
  my $output = qq{
    <h2>Edit File</h2>
    Filename: $host:$file<br>
    <textarea style='width:100\%;height:30em' name=content>$content</textarea>
    <input type=submit name="email-action" value="Save">
    <input type=submit name="email-action" value="Cancel">
  };
  $self->display($output);
  my $action = $self->param('email-action');
  if($action eq 'Save') {
    $content = $self->param('content');
    write_file("/home/$username/.epfarms-panel/tmp/$local_file", $content);
    $scp->scp("/home/$username/.epfarms-panel/tmp/$local_file", "$host:$file");
    $self->display("Saved!");
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


