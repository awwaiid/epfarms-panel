package EPFarms::Panel::Auth;

use strict;
use base 'EPFarms::Panel::Base';
use Net::Telnet;
use EPFarms::Panel::User;

sub get_authenticated_user {
  my ($self) = @_;
  unless($self->{auth_ok}) {
    $self->do_auth;
  }
  return $self->{user};
}

sub do_auth {
  my ($self) = @_;
  my $msg;
  my $page = DOMTemplate->new('tpl/modal-dialog.tpl');
  my $sid = $self->{request}->session_id;
  $page->set('dialog' => qq{
      <h2>Please login</h2>
      <i>(and Don't Panic!)</i>
      <form method=POST>
        <input type=hidden id=sid name=sid value="$sid">
        <input type=hidden id="has_javascript" name="has_javascript" value="0">
        <script>document.getElementById('has_javascript').value = 1;</script>
        <b>$msg</b>
        <table border=0 cellspacing=0 cellpadding=4>
          <tr>
            <th>Username:</th>
            <td><input type=text id=username name=username></td>
          </tr>
          <tr>
            <th>Password:</th>
            <td><input type=password name=password></td>
          </tr>
          <tr>
            <td colspan=2><input type=submit name=login value="Login"></td>
          </tr>
        </table>
        <script>document.getElementById('username').focus()</script>
      </form>
  });
  $page->set_value('sid', $self->{request}->session_id);
  while(1) {
    $self->{request}->print($page->as_HTML);
    $self->{request}->next;
    my $username = $self->param('username');
    my $password = $self->param('password');
    my $c = Net::Telnet->new('localhost');
    $c->errmode("return");
    if($c->login($username, $password)) {
      my $user = EPFarms::Panel::User->new(
        auth_ok => 1,
        has_javascript => $self->param('has_javascript'),
        username => $username,
      );
      $self->{user} = $user;
      return;
    }
    $msg = "Login incorrect.\n";
  }
}

1;

