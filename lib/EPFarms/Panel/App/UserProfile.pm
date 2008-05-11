
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
    Name:
      <input type=text name=name value="@{[ $user->usr_name ]}"><br>
    External Email:
      <input type=text name=email value="@{[ $user->usr_external_email ]}"><br>
    Alternate Contact:
      <input type=text name=contact value="@{[ $user->usr_contact ]}"><br>
    <input type=submit name=save value="Save">
  |);

  if($self->param('save')) {
    my ($contact, $email, $name) = $self->param(qw( contact email name ));
    $user->usr_contact($contact);
    $user->usr_external_email($email);
    $user->usr_name($name);
    $user->update;
    $self->display(qq|
      Updated.<br>
      Username: $username<br>
      Name: $name<br>
      External Email: $email<br>
      Alternate Contact: $contact
    |);
  }

}

1;


