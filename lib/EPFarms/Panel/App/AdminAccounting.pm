package EPFarms::Panel::App::AdminAccounting;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_accounting',
  title => 'Accounting Admin',
  icon => 'img/famfam/icons/money.png',
  user_group => 'paneldev',
}});

has callback => (is => 'rw', default => sub{{}});

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
  if(defined $self->callback->{$name}) {
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
        <table class="data">
          <thead>
            <tr class=header>
              <th>Date</th>
              <th>Description</th>
              <th>Amount</th>
            </tr>
          </thead>
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

