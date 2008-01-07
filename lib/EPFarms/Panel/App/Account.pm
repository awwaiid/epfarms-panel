
package EPFarms::Panel::App::Account;

use Moose;
extends 'EPFarms::Panel::App';

has '+config' => (default => sub {{
  rank => '10',
  name => 'account_finance',
  title => 'Account Finances',
  icon => 'img/famfam/icons/money.png',
}});

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=cut

use EPFarms::Effin;

sub main {
  my ($self) = @_;
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );
  my $tpl = DOMTemplate->new('tpl/accounting.html');
  $tpl->set('.username' => $username);
  $tpl->set('#item_name' => "Deposit for $username");

  while(1) {

    # Fill in the transaction history
    my $bal = 0;
    my @transactions = $db->resultset('MyTransactions')->search(
      undef, {order_by => 'trn_date'});
    if(@transactions) {
      my $rows = [
        map {[
          $_->trn_date->ymd,
          $_->trn_memo,
          (sprintf '$%.02f', $_->trn_amount),
          (sprintf '$%.02f', $bal += $_->trn_amount)
        ]} @transactions
      ];
      $tpl->fill_rows('#transaction-data tbody' => $rows);
    } else {
      $tpl->set('#transaction-data' => 'NO TRANSACTIONS');
      $bal = '---';
    }

    $tpl->set('#balance' => $bal);

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


