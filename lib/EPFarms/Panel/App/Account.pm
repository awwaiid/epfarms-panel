
package EPFarms::Panel::App::Account;

use strict;
use EPFarms::Panel::AppBase;
use base 'EPFarms::Panel::AppBase';

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=cut

sub new {
  my $class = shift;
  my $self = $class->SUPER::new(@_);

  $self->{panel}->add_sidebar_action(
    name => 'account_finance',
    title => 'Account Finances',
    icon => 'img/famfam/icons/money.png',
    code => sub { $self->show_finances }
  );

  return $self;
}

sub message {
  my ($self, $msg) = @_;
  print STDERR "MESSAGE: $msg\n";
}

sub show_finances {
  my ($self) = @_;
  $self->display(qq{
      <h2>Finances</h2>
      <h3>Balance: <span id="balance">\$0</span></h3>
      <h3>Transaction History:</h3>
      <table border=0 cellspacing=0 cellpadding=4>
        <tr>
          <th>Date</th>
          <th>Title</th>
          <th>Amount</th>
          <th>Balance</th>
        </tr>
        <tr>
          <td>2007/08/01</td>
          <td>Deposit</td>
          <td>\$20.00</td>
          <td>\$20.00</td>
        </tr>
      </table>
      
      <h2>Add Money To Account</h2>
      <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
         <input type="hidden" name="cmd" value="_xclick">
         <!-- <input type="hidden" name="business" value="epfarms\@epfarms.org"> -->
         <input type="hidden" name="business" value="awwaii_1187467527_biz\@eggplantfarms.org">
         <input type="hidden" name="item_name" 
         value="EPFarms Account Deposit">
         <input type="hidden" name="item_number" 
         value="Item Number Goes Here">
         <input type="hidden" name="on0" value="USERNAME">
         <input type="hidden" name="amount" value="100.00">
         <input type="hidden" name="no_shipping" value="2">
         <input type="hidden" name="no_note" value="1">
         <input type="hidden" name="currency_code" value="USD">
         <input type="hidden" name="bn" value="IC_Sample">
         <input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but23.gif" 
         name="submit" alt="Make payments with payPal - it's fast, 
         free and secure!>
         <img alt="" 
         src="https://www.paypal.com/en_US/i/scr/pixel.gif" 
         width="1" height="1">
      </form>
  });
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


