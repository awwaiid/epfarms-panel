class EPFarms::Panel::App::AdminAccounting extends EPFarms::Panel::App {

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_accounting',
  title => 'Accounting Admin',
  icon => 'img/famfam/icons/money_dollar.png',
  user_group => 'paneldev',
}});

sub main {
  my ($self) = @_;
  my $db = EPFarms::DB->new;
  do {
    my $out = "<table class=data>
      <thead>
        <tr class=header>
          <th>User</th>
          <th>Balance</th>
        </tr>
      </thead>";
      say STDERR "Loading users...";
      my @users = $db->content->users->members;
      @users = sort { $a->username cmp $b->username } @users;
      say STDERR "done.";
    foreach my $user (@users) {
    my $balance = $user->balance_formatted();
      $out .= qq{
        <tr>
          <td>
            @{[
              $self->add_link($user->username => sub { $self->user_detail($user) })
            ]}
        </td>
              $balance
        <td>
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
      <h2>User: @{[$user->username]}</h2>
      Balance: @{[$user->balance_formatted]}<br>
    |;
    my @transactions = $user->transactions->members;
    if(scalar (@transactions) > 0) {
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
      foreach my $transaction (@transactions) {
        $out .= qq|
          <tr>
            <td>@{[$transaction->timestamp->ymd]}</td>
            <td>@{[$transaction->description]}</td>
            <td>@{[$transaction->amount]}</td>
          </tr>
        |;
      }
      $out .= "</table>";
    }
    $self->display($out);
  } while $self->process_links;
}

}

1;

