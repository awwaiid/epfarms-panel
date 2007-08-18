
package EPFarms::Panel::App::Passwd;

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

sub show_change_password {
  my ($self) = @_;
  $self->display(qq{
      <h2>Password Changer</h2>
      <h3>Change ALL user passwords (shell/ftp, email, and mysql)</h3>
      <table border=0 cellspacing=0 cellpadding=4>
        <tr>
          <th>New Password:</th>
          <td><input type=password name=password1></td>
        </tr>
        <tr>
          <th>New Password Again:</th>
          <td><input type=password name=password2></td>
        </tr>
        <tr>
          <td colspan=2>
            <input type=submit name=change value="Change Password">
            <input type=submit name=cancel value="Cancel">
          </td>
        </tr>
      </table>
      <script>document.getElementById('password1').focus()</script>
      
      <h3>Shell Password</h3>
      <table border=0 cellspacing=0 cellpadding=4>
        <tr>
          <th>New Password:</th>
          <td><input type=password name=password1></td>
        </tr>
        <tr>
          <th>New Password Again:</th>
          <td><input type=password name=password2></td>
        </tr>
        <tr>
          <td colspan=2>
            <input type=submit name=change value="Change Password">
            <input type=submit name=cancel value="Cancel">
          </td>
        </tr>
      </table>
  });
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


