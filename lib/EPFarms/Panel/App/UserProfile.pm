
class EPFarms::Panel::App::UserProfile extends EPFarms::Panel::App {

use EPFarms::DB;

has '+config' => (default => sub {{
  rank => '10',
  name => 'user_profile',
  title => 'User Profile',
  icon => 'img/famfam/icons/user.png',
}});

method main {
  my $db = EPFarms::DB->new;
  my $username = $self->panel->user->username;
  my ($user) = $db->search(username => $username);
  
  $self->display(qq|
    <h2>User Profile</h2>
    Username: @{[ $user->username ]}<br>
    Name:
      <input type=text name=name value="@{[ $user->name ]}"><br>
    External Email:
      <input type=text name=email value="@{[ $user->external_email ]}"><br>
    Alternate Contact:
      <input type=text name=contact value="@{[ $user->contact ]}"><br>
    <input type=submit name=save value="Save">
  |);

  if($self->param('save')) {
    my $contact = $self->param('contact');
    my $email = $self->param('email');
    my $name = $self->param('name');
    $user->contact($contact);
    $user->external_email($email);
    $user->name($name);
    $db->db->update($user);
    $self->display(qq|
      Updated.<br>
      Username: $username<br>
      Name: $name<br>
      External Email: $email<br>
      Alternate Contact: $contact
    |);
  }
}

}

1;


