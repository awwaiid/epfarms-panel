
package EPFarms::Panel::App::Passwd;

use strict;
use EPFarms::Panel::AppBase;
use base 'EPFarms::Panel::AppBase';
use Expect;
$Expect::Log_Stdout = 0;

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=cut

sub new {
  my $class = shift;
  my $self = $class->SUPER::new(@_);

  $self->{request} = $self->{panel}->{request};

  $self->{panel}->add_sidebar_action(
    name => 'change_password',
    title => 'Change Passwords',
    icon => 'img/famfam/icons/key.png',
    code => sub { $self->show_change_password() }
  );

  return $self;
}

sub debug {
  my ($self, $msg) = @_;
  print STDERR "DEBUG: $msg\n";
}

sub password_template {
  my ($self) = @_;
  return qq{
      <h2>Password Changer</h2>
      <h3>Change passwords</h3>

      <input type=checkbox name="change" value="shell" checked>
      Change shell, FTP, and email passwords
      <!--
      <br>
      <input type=checkbox name="change" value="mysql" checked>
      Change MySQL password
      -->

      <table border=0 cellspacing=0 cellpadding=4>
        <tr>
          <th>Current Password:</th>
          <td><input type=password name="cur_password"></td>
        </tr>
        <tr>
          <th>New Password:</th>
          <td><input type=password name="new_password1"></td>
        </tr>
        <tr>
          <th>New Password Again:</th>
          <td><input type=password name="new_password2"></td>
        </tr>
        <tr>
          <td colspan=2>
            <input type=submit name=passwd_action value="Change Password(s)">
            (it takes a minute after you submit!)
          </td>
        </tr>
      </table>
      <script>document.getElementById('password1').focus()</script>

      <!--
      <h2>Password Reset</h2>

      <p>Use this if you need to reset your MySQL password. Since you were able
      to log in to the panel, it doesn't make much sense for you to reset your
      shell password, now does it?</p>

      <p><input type=submit name=passwd_action value="Reset MySQL Password"></p>
      -->
  };
}

sub changeSSHPass {
  my ($self, $host, $cur, $pass1, $pass2) = @_;
  my $result = 'ERROR';
  my $timeout = 10;
  my $passwd = Expect->spawn(
    "ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password $host");
  #$passwd->log_file("/tmp/passwd_log.txt");
  $passwd->expect($timeout,
    [ qr/assword: /                    => sub { print $passwd "$cur\n";   exp_continue }],
    [ qr/:(\\|~)\$ /                   => sub { print $passwd "passwd\n"; exp_continue }],
    [ qr/^\(current\) UNIX password: / => sub { print $passwd "$cur\n";   exp_continue }],
    [ qr/^Enter new UNIX password: /   => sub { print $passwd "$pass1\n"; exp_continue }],
    [ qr/^Retype new UNIX password: /  => sub { print $passwd "$pass2\n"; exp_continue }],
    [ qr/^(passwd:|Bad:|Sorry,) .*$/   => sub { $result = $passwd->match() }]
  );
  $passwd->hard_close();
  return $result;
}

sub show_change_password {
  my ($self) = @_;
  my $tpl = $self->password_template;
  print STDERR "self: $self\ntpl: $tpl\n\n";
  $self->display($tpl);

  my $action = $self->param('passwd_action');
  if($action eq "Change Password(s)") {

    my $cur_password = $self->param('cur_password');
    my $password1 = $self->param('new_password1');
    my $password2 = $self->param('new_password2');

    # TODO: insert some user-input sanity checks
    
    my $mirabel_shell_result = $self->changeSSHPass(
      'mirabel.epfarms.org',$cur_password, $password1, $password2);

    my $pointless_shell_result = $self->changeSSHPass(
      'pointless.epfarms.org',$cur_password, $password1, $password2);

    $self->display(qq{
      Mirabel Result: $mirabel_shell_result<br>
      Pointless Result: $pointless_shell_result<br>
      <a href="change_password">Return to password changer</a>
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


