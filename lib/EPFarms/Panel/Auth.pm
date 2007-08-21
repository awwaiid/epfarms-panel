package EPFarms::Panel::Auth;

use strict;
use base 'EPFarms::Panel::Base';
use Authen::Simple::FTP;
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
  my $page = DOMTemplate->new('tpl/modal-dialog.html');
  my $sid = $self->{request}->session_id;
  $page->set('dialog' => qq|
    <script>
      \$(function() {
        if(location.href.indexOf("localhost") == -1) {
          \$('#f').submit(function() {
            \$('#f').attr('action',('/~' + f.username.value + '/epfarms-panel/'));
            alert('Submitting to: ' + \$('#f').attr('action'));
          });
        }
      });
    </script>
      <h2>Please login</h2>
      <i>(and Don't Panic!)</i>
      <span id=msg></span>
      <form name=f id=f method=POST>
        <input type=hidden id=sid name=sid value="$sid">
        <input type=hidden id="has_javascript" name="has_javascript" value="0">
        <script>\$('#has_javascript').val(1)</script>
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
            <td colspan=2><input id=login type=submit name=login value="Login"></td>
          </tr>
        </table>
        <script>\$('#username').focus()</script>
      </form>
  |);
  $page->set_value('sid', $self->{request}->session_id);
  while(1) {
    $page->set(msg => $msg);
    $self->{request}->print($page->as_HTML);
    $self->{request}->next;
    my $username = $self->param('username');
    my $password = $self->param('password');
    my $c = Authen::Simple::FTP->new(host => 'localhost');
    my $process_user = getlogin();
    if($process_user ne $username) {
      $msg = "Wrong user!";
      next;
    }
    if($c->authenticate($username, $password)) {
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

