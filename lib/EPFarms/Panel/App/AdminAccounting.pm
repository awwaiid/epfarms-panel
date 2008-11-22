package EPFarms::Panel::App::AdminAccounting;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_accounting',
  title => 'Accounting Admin',
  icon => 'img/famfam/icons/money_dollar.png',
  user_group => 'paneldev',
}});

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
    my $out = "<table class=data>
      <thead>
        <tr class=header>
          <th>User</th>
          <th>Balance</th>
        </tr>
      </thead>";
    my @users = $db->resultset('Users')->search(undef,{order_by => 'usr_nname'});
    foreach my $user (@users) {
      $out .= qq{
        <tr>
          <td>
            @{[
              $self->add_link($user->usr_nname => sub { $self->user_detail($user) })
            ]}
        </td>
        <td>
        @{[ $user->balance_formatted ]}
        </td></tr>
      };
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
      foreach my $transaction ($user->transactions(undef,{order_by => 'trn_date'})) {
        $out .= qq|
          <tr>
            <td>@{[$transaction->trn_date->ymd]}</td>
            <td>@{[$transaction->trn_memo]}</td>
            <td>@{[$transaction->trn_amount_formatted]}</td>
          </tr>
        |;
      }
      $out .= "</table>";
    }
    $self->display($out);
  } while $self->process_links;
}


1;

