
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

use DBI;

sub get_mysql_auth {
  my ($self) = @_;
  my $dsn = 'DBI:mysql:database=epfarms_effin_effin';
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};

  # First try with what we have
  eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
  return ($username, $password) unless $@;

  while(1) {

    $password = `cat ~/.epfarms-panel/mysql_password`;
    chomp $password;

    # Try with the cached password
    eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
    return ($username, $password) unless $@;

    # Then ask for the password
    $self->display(qq|
      <p>Our default entry for your MySQL username and password failed. If you
      do not use MySQL in any web applications, you can just reset your
      password and continue.</p>
      <br>
      
      <input type=submit name="resetpassword" value="Reset MySQL Password">

      <p>If you do use your MySQL password in web applications, you might have
      set a separate MySQL password. Please enter your MySQL username and
      password, and I will remember it in the future.</p>

      <br><br>

      Username: <input type=text name=username value="$username"><br>
      Password: <input type=password name=password><br>

      <input type=submit name="authenticate" value="Authenticate to MySQL">
    |);

    if($self->param('resetpassword')) {
      `/usr/local/bin/mysql_passwd_reset -y`;
      $password = `cat ~/.epfarms-panel/mysql_password`;
      chomp $password;
      $self->display(qq{
        <p>Password reset to '$password'. You may want to keep this password in
        case you install any MySQL-based web applications, though you can
        always reset it again later.</p>
        <br><br>
        <input type=submit value=Continue>
      });
    } else {
      $username = $self->param('username');
      $password = $self->param('password');
      print STDERR "Trying MySQL User: $username\n";

      eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
      return ($username, $password) unless $@;

      print STDERR "Error logging in to DB: $@\n";
      $self->display(qq|
        <p>Well that didn't work either. I'm letting support know that there is a problem and they will contact you. You can try again too, if you like.</p>
        <p>(DB Error: $@)</p>
      |);
      return;
    }
  }

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


