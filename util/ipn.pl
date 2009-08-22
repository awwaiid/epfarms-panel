#!/usr/bin/perl

use lib '/usr/local/lib/EPFarms-Panel/lib';
use Data::Dumper;
use EPFarms::DB;

# read post from PayPal system and add 'cmd'
read (STDIN, $query, $ENV{'CONTENT_LENGTH'});
$query .= '&cmd=_notify-validate';

# post back to PayPal system to validate
use LWP::UserAgent;
$ua = new LWP::UserAgent;
#$req = new HTTP::Request 'POST','https://www.sandbox.paypal.com/cgi-bin/webscr';
$req = new HTTP::Request 'POST','https://www.paypal.com/cgi-bin/webscr';

$req->content_type('application/x-www-form-urlencoded');
$req->content($query);
$res = $ua->request($req);

# split posted variables into pairs
@pairs = split(/&/, $query);
$count = 0;
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $variable{$name} = $value;
  $count++;
}

if ($res->is_error) {
  # HTTP error
} elsif ($res->content eq 'VERIFIED') {
  # check the payment_status=Completed
  # check that txn_id has not been previously processed
  # check that receiver_email is an email address in your PayPal account
  # process payment
  # print to screen the following if the IPN POST was VERIFIED

  open my $out, ">>", "out.txt";
  print $out "VERIFIED:\n";
  print $out Dumper(\%variable) . "\n\n";

  # Lets consider actually posting this transaction!
  if($variable{payment_status} eq 'Completed') {
    my $username = $variable{option_name1} || 'unknown_user';
    my $mc_fee = $variable{mc_fee};
    my $mc_gross = $variable{mc_gross};
    my $exchange_rate = $variable{exchange_rate} || 1;
    my $fee = $mc_fee * $exchange_rate;
    my $gross = $mc_gross * $exchange_rate;
    my $amount = $gross - $fee;
    my $txn_id = $variable{txn_id};
    # Dates are like: 'payment_date' => '09:20:38 Oct 13, 2007 PDT',
    my $payment_date = $variable{payment_date};
    if($payment_date =~ /^([^ ]+) (\w+) (\d+), (\d+) (\w+)$/) {
      $payment_date = "$3 $2 $4 $1 $5";
    }

    print $out qq{

    Date: '$payment_date'

    INSERT INTO transactions
       SET trn_usr_efid = (select usr_efid from users where usr_nname = '$username'),
           trn_amount = $amount,
           trn_memo = 'Payment from paypal',
           trn_date = NOW(),
           trn_tranid = '$txn_id',
           trn_createdon = NOW();
    };

    my $db = EPFarms::DB->new;
    my ($user) = $db->search(username => $username);
    my $transaction = EPFarms::Transaction->new(
      amount => $amount,
      description => 'Payment from paypal',
      reference_number => $txn_id,
      user => $user,
    );
    $user->add_transaction($transaction);

  }

} elsif ($res->content eq 'INVALID') {
  # log for manual investigation
  # print to screen the following if the IPN POST was INVALID

  open my $out, ">>", "out.txt";
  print $out "INVALID\n";
  print $out Dumper(\%variable) . "\n\n";

} else {
  open my $out, ">>", "out.txt";
  print $out "ERROR\n";
  print $out Dumper(\%variable) . "\n\n";
}

print "Content-type: text/html\n\n";
print "OK";

