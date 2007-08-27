
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
      Current Balance: <span id="balance">\$4.00</span><br>
      Paid Until (estimated): 2007/10/31
      
      <h2>Add Money To Account</h2>
      </form>

      <p>The easiest way to deposit money into your pre-paid Eggplant Farms
      account is through our Paypal payment gateway. <b>You do not have to use
      a Paypal account!</b> Paypal will accept any major credit card directly
      without signing up with them.</p>

      <p>Please use this form to send us payments. You can see here how much
      the transaction fee will be, which you are responsible for, and how much
      will actually go into your account. After entering an amount you will be
      redirected to Paypal's site to complete the details.</p>

      <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
         <input type="hidden" name="cmd" value="_xclick">
         <input type="hidden" name="business" value="epfarms\@epfarms.org">
         <!-- <input type="hidden" name="business" value="awwaii_1187467527_biz\@eggplantfarms.org"> -->
         <input type="hidden" name="item_name" 
         value="EPFarms Account Deposit">
         <input type="hidden" name="on0" value="USERNAME">
         <input type="hidden" name="no_shipping" value="2">
         <input type="hidden" name="no_note" value="1">
         <input type="hidden" name="currency_code" value="USD">
         <input type="hidden" name="bn" value="IC_Sample">

         <table border=0 cellspacing=0 cellpadding=4>
           <tr>
             <th align=right>Charge Amount:</th>
             <td><input type="text" id="charge-amount" name="charge-amount" value="24.00" size=6></td>
           </tr>
           <tr>
             <th align=right>Fee Amount:</th>
             <td><input type="text" id="fee-amount" name="fee-amount" value="1.50" size=6></td>
           </tr>
           <tr>
             <th align=right>Deposit Amount:</th>
             <td><input type="text" id="amount" name="amount" value="22.50" size=6></td>
           </tr>
           <tr>
             <td colspan=2>
               <input type="submit" name="submit" value="Add to account!">
             </td>
           </tr>
         </table>

      </form>
      <h2>Transaction History</h2>
      <table border=0 cellspacing=0 cellpadding=4 width="100%" class="data">
        <thead>
        <tr class="header">
          <th>Date</th>
          <th>Title</th>
          <th>Origin</th>
          <th>Amount</th>
          <th>Balance</th>
        </tr>
        </thead>
        <tbody>
        <tr class="even"> <td>2007/01/01</td><td>Deposit by user</td> <td>Paypal</td><td>\$20.00</td> <td>\$20.00</td> </tr>
        <tr class="odd"> <td>2007/01/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$18.00</td> </tr>
        <tr class="even"> <td>2007/02/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$16.00</td> </tr>
        <tr class="odd"> <td>2007/03/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$14.00</td> </tr>
        <tr class="even"> <td>2007/04/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$12.00</td> </tr>
        <tr class="odd"> <td>2007/05/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$10.00</td> </tr>
        <tr class="even"> <td>2007/06/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$8.00</td> </tr>
        <tr class="odd"> <td>2007/07/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$6.00</td> </tr>
        <tr class="even"> <td>2007/08/01</td><td>Monthly Hosting Fee</td> <td>EPFarms</td><td>-\$2.00</td> <td>\$4.00</td> </tr>
      </tbody>
      </table>
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


