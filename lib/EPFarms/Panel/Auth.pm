package EPFarms::Panel::Auth;

use Moose;
extends 'EPFarms::Panel::Base';

use Authen::Simple::FTP;
use Net::FTP;
use EPFarms::Panel::User;

has 'user' => ( is => 'rw' );

# We have one unique user per process
our $user_token = (rand) . (rand) . (rand);
our $auth_user;

sub get_authenticated_user {
  my ($self) = @_;
  my $token = $self->request->get_cookie('auth_token') || '';
  if($token eq $user_token) {
    $self->user($auth_user);
    return $self->user;
  }
  unless($self->user && $self->user->auth_ok) {
    $self->do_auth;
  }
  return unless $self->user;
  $auth_user = $self->user;
  $self->request->set_cookie(CGI->cookie(
    -name => 'auth_token',
    -value => $user_token));
  return $self->user;
}

sub logout {
  my ($self) = @_;
  # Reset the user token
  $user_token = (rand) . (rand) . (rand);
  $self->user->auth_ok(0);
}

sub do_auth {
  my ($self) = @_;

  my $msg = '';
  my $page = DOMTemplate->new('tpl/modal-dialog.html');
  my $sid = $self->request->session_id;
  $page->set('#dialog' => qq|
    <script>
      \$(function() {
        if(location.href.indexOf("epfarms.org") > -1 &&
          location.href.indexOf("-dev") == -1) {
          \$('#f').submit(function() {
            var new_url = '/~' + \$('#username').val() + '/epfarms-panel/';
            var m = location.href.match(/(epfarms-)?panel\\\/(.*)\$/);
            if(m[2]) {
              new_url += m[2];
            }
            \$('#f').attr('action', new_url);
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
  $page->set('#sid', $self->request->session_id);
  while(1) {
    my $username = $self->param('username');
    my $password = $self->param('password');
    my $c = Authen::Simple::FTP->new(host => 'localhost');
    my $process_user = getpwuid($<);
    print STDERR "process_user: <$process_user>\tusername: <$username>\n";
    if($username && $process_user ne $username) {
      $msg = "Wrong user!";
    } elsif($username && $c->authenticate($username, $password)) {
      my $user = EPFarms::Panel::User->new(
        auth_ok => 1,
        has_javascript => $self->param('has_javascript'),
        username => $username,
        password => $password,
      );
      $self->user($user);
      $self->setup_remote_access($password);
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

sub setup_remote_access {
  my ($self, $password) = @_;
  my $conf_dir = "/home/" . $self->user->username . "/.epfarms-panel";
  unless(-d $conf_dir) {
    print STDERR "Creating configuration directory.\n";
    mkdir $conf_dir;
    `chmod 700 $conf_dir`;
    mkdir "$conf_dir/tmp";
  }
  # unless(-e "$conf_dir/rsa_key") {
    # print STDERR "Generating ssh key for remote access.\n";
    # `ssh-keygen -t rsa -N "" -f $conf_dir/rsa_key`;
    # print STDERR "Copying public ssh key to pointless.\n";
    # my $ftp = Net::FTP->new("pointless.epfarms.org", Passive => 1)
      # or print STDERR "FTP connect faild\n";
    # $ftp->login($self->user->{username}, $password)
      # or print STDERR "FTP auth faild\n";
    # $ftp->mkdir('.ssh')
      # or print STDERR "FTP mkdir faild\n" . $ftp->message;
    # $ftp->append("$conf_dir/rsa_key.pub", '.ssh/authorized_keys')
      # or print STDERR "FTP append faild\n" . $ftp->message;
    # $ftp->quit;
    # print STDERR "Done setting up remote access.\n";
  # }
}


1;

