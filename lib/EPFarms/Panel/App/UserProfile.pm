
package EPFarms::Panel::App::UserProfile;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '10',
  name => 'user_profile',
  title => 'User Profile',
  icon => 'img/famfam/icons/user.png',
}});

sub main {
  my ($self) = @_;
  my $username = $self->{panel}->{user}->{username};
  my $db = $self->get_effin_db;
  my $user = $db->resultset('MyUsers')->single;
  
  $self->display(qq|
    <h2>User Profile</h2>
    Username: @{[ $user->usr_nname ]}<br>
    Contact (email): <input type=text name=contact value="@{[ $user->usr_contact ]}"><br>
    <input type=submit name=save value="Save">
  |);

  if($self->param('save')) {
    my $contact = $self->param('contact');
    $user->usr_contact($contact);
    $user->update;
    $self->display('updated.');
  }

}

1;


