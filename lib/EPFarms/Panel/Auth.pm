package EPFarms::Panel::Auth;

use Moose;
extends 'EPFarms::Panel::Base';

use Authen::Simple::FTP;
use Net::FTP;
use EPFarms::Panel::User;

has 'user' => ( is => 'rw' );
has 'auth_token' => ( is => 'rw' );

# $token => $user
our $auth_users = {};

sub create_auth_token {
  return (rand).(rand).(rand);
}

sub get_authenticated_user {
  my ($self) = @_;
  my $auth_token = $self->request->get_cookie('auth_token') || '';
  if($auth_token && $auth_users->{$auth_token}) {
    $self->user($auth_users->{$auth_token});
    $self->user->last_auth(time());
    return $self->user;
  }
  unless($self->user && $self->user->auth_ok) {
    $self->do_auth;
  }
  return unless $self->user;
  $auth_token = $self->create_auth_token;
  $self->user->auth_token($auth_token);
  $auth_users->{$auth_token} = $self->user;
  $self->request->set_cookie(CGI->cookie(
    -name => 'auth_token',
    -value => $auth_token
  ));
  return $self->user;
}

sub logout {
  my ($self) = @_;
  # Reset the user token
  delete $auth_users->{$self->user->auth_token};
  $self->user->auth_ok(0);
}

sub do_auth {
  my ($self) = @_;

  my $msg = '';
  my $page = DOMTemplate->new('tpl/modal-dialog.html');
  my $sid = $self->request->session_id;
  $page->set('#dialog' => qq|
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
          <td><input type=text id=username name=username size=15></td>
        </tr>
        <tr>
          <th>Password:</th>
          <td><input type=password name=password size=15></td>
        </tr>
        <tr>
          <td colspan=2><input id=login type=submit name=login value="Login"></td>
        </tr>
      </table>
      <script>\$('#username').focus()</script>
    </form>
  |);
  $page->set('#sid', $self->request->session_id);
  while(1) {
    my $username = $self->param('username') || '';
    my $password = $self->param('password');
    my $c = Authen::Simple::FTP->new(host => 'localhost');
    if($username && $c->authenticate($username, $password)) {
      my $user = EPFarms::Panel::User->new(
        auth_ok => 1,
        has_javascript => $self->param('has_javascript'),
        username => $username,
        password => $password,
        last_active => time(),
      );
      $self->user($user);
      return $self->user;
    } elsif($username) {
      $msg = "Login incorrect.\n";
    }
    print STDERR "Message: $msg\n";
    $page->set('#msg' => $msg);
    $self->request->print($page->as_HTML);
    return;
    #$self->request->next;
  }
}

1;

