package EPFarms::Panel::App::Account;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;

has '+config' => (default => sub {{
  rank => '10',
  name => 'account_finance',
  title => 'Account Finances',
  icon => 'img/famfam/icons/money.png',
}});

=head1 NAME

EPFarms::Panel::App::Account - Allow users to view their financial standings

=head1 DESCRIPTION

Let users see their account balance and transaction history. Also a nice place
for them to make payments.

=head1 METHODS

=cut

use EPFarms::DB;

sub main {
  my ($self) = @_;
  my $db = EPFarms::DB->new;
  my $username = $self->panel->user->username;
  my $user = $db->find_user(username => $username);
  my $tpl = DOMTemplate->new('tpl/accounting.html');
  $tpl->set('.username' => $username);
  $tpl->set('#item_name' => "Deposit for $username");

  while(1) {

    # Fill in the transaction history
    my $bal = 0;
    my @transactions = $user->transactions->members;
    @transactions =
      map { $_->[1] }
      sort { $a->[0] cmp $b->[0] }
      map { [ $_->timestamp->ymd, $_ ] }
      @transactions;
    if(@transactions) {
      my $rows = [
        map {[
          $_->timestamp->ymd,
          $_->description,
          (sprintf '$%.02f', $_->amount),
          (sprintf '$%.02f', $bal += $_->amount)
        ]} @transactions
      ];
      $tpl->fill_rows('#transaction-data tbody' => $rows);
    } else {
      $tpl->set('#transaction-data' => 'NO TRANSACTIONS');
      $bal = '--- (we have no transactions on record for this account)';
    }

    $bal = sprintf '%.02f', $bal;

    my $bal_msg = '';
    if($bal >= 0) {
      $bal_msg = "I see that your account has a positive balance. This means that you have pre-paid \$$bal and are in good standing.";
    } elsif($bal < 0) {
      my $neg_bal = 0 - $bal;
      $bal_msg = "I see that your account has a negative balance. This means that you must pay at least \$$neg_bal to be in good standing.";
    }
      
    $tpl->set('#balance' => $bal);
    $tpl->set('#balance-msg' => $bal_msg);

    $self->display( $tpl->render );
    my $action = $self->get_action;
    if($action ne 'account_finance') {
      return;
    }
  }
}

=head1 SEE ALSO

L<EPFarms::Panel::App>
L<EPFarms::Panel>
L<http://community.epfarms.org/Panel_Documentation>

=head1 AUTHOR

Brock Wilcox, E<lt>awwaiid@epfarms.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Brock Wilcox

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;


