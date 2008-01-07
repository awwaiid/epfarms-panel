package EPFarms::Panel::App::EffinTest;

use Moose;
extends 'EPFarms::Panel::App';

has '+config' => (default => sub {{
  rank => '99',
  name => 'effin_test',
  title => 'Effin Test',
  icon => 'img/famfam/icons/script.png',
  user_group => 'paneldev',
}});

use EPFarms::Effin;

sub main {
  my $self = shift;
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );
  my $out = '';
  my @ok_users = split(' ', (getgrnam('paneldev'))[3]);
  $out .= "paneldev users: @ok_users<br>";


  foreach my $user ($db->resultset('Users')->all) {
    $out .= "<h3>" . $user->usr_nname . "</h3>\n";
    if(scalar ($user->transactions) > 0) {
      $out .= q{
        <h4>Transactions</h4>
        <table border=1 cellspacing=0 cellpadding=2 width="100%">
          <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Amount</th>
          </tr>
      };
      foreach my $transaction ($user->transactions) {
        $out .= "<tr>"
          . "<td>" . $transaction->trn_date . "</td>\n"
          . "<td>" . $transaction->trn_memo . "</td>\n"
          . "<td>" . $transaction->trn_amount . "</td>\n"
          . "</tr>\n";
      }
      $out .= "</table>";
    }
  }
  $self->display($out);
}

1;

