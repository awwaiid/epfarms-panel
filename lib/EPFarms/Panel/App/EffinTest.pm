package EPFarms::Panel::App::EffinTest;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '99',
  name => 'effin_test',
  title => 'Effin Test',
  icon => 'img/famfam/icons/script.png',
  user_group => 'paneldev',
}});

has callback => (is => 'rw', default => sub{{}});

sub get_mysql_auth {
  my ($self) = @_;
  my $dsn = 'DBI:mysql:database=epfarms_effin_effin';
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};

  # First try with what we have
  eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
  return ($username, $password) unless $@;

  # Then ask for the password
  $self->display(qq|
    <p>Our default entry for your MySQL username and password failed. Please enter your MySQL username and password. This will be automated in the near future.</p>
    <br><br>
    Username: <input type=text name=username value="$username"><br>
    Password: <input type=password name=password><br>
    <input type=submit>
  |);
  my $username = $self->param('username');
  my $password = $self->param('password');
  print STDERR "Trying MySQL User: $username\n";

  eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
  return ($username, $password) unless $@;

  $self->display(qq|
    <p>Well that didn't work either. I'm letting support know that there is a problem and they will contact you. You can try again too, if you like.</p>
  |);
  return;

}

sub add_link {
  my ($self, $text, $subref) = @_;
  my $name = scalar $subref;
  $name =~ s/CODE\(0x(.*)\)/$1/;
  $self->callback->{$name} = $subref;
  return qq{<a href="?callback=$name">$text</a>};
}

sub process_links {
  my ($self) = @_;
  my $name = $self->param('callback');
  if($self->callback->{$name}) {
    $self->callback->{$name}->();
    $self->callback({});
    return 1;
  }
  # Reset callback hash
  $self->callback({});
  return 0;
}

sub main {
  my ($self) = @_;
  my ($username, $password) = $self->get_mysql_auth;
  return unless $username;
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );

  do {
    my $out = '';

    $out .= "<table class=data>
      <thead>
        <tr class=header>
          <th>User</th>
          <th>Balance</th>
        </tr>
      </thead>";
    foreach my $user ($db->resultset('Users')->all) {
      $out .= "<tr><td>"
        . $self->add_link($user->usr_nname => sub { $self->user_detail($user) })
        . "</td>"
        . "<td>"
        . $user->balance_formatted
        . "</td></tr>";
    }
    $out .= "</table>";

    $self->display($out);
  } while $self->process_links;
}

sub add_transaction_for {
  my ($self, $user) = @_;
  $self->display("Hello! Examining user: " . $user->usr_nname);
}


sub user_detail {
  my ($self, $user) = @_;
  do {
    my $out = qq|
      <h2>User: @{[$user->usr_nname]}</h2>
      Balance: @{[$user->balance_formatted]}<br>
    |;
    if(scalar ($user->transactions) > 0) {
      $out .= qq|
        <h4>Transactions</h4>
        <table border=1 cellspacing=0 cellpadding=2 width="100%">
          <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Amount</th>
          </tr>
      |;
      foreach my $transaction ($user->transactions) {
        $out .= qq|
          <tr>
            <td>@{[$transaction->trn_date]}</td>
            <td>@{[$transaction->trn_memo]}</td>
            <td>@{[$transaction->trn_amount]}</td>
          </tr>
        |;
      }
      $out .= "</table>";
    }
    $self->display($out);
  } while $self->process_links;
}


1;

