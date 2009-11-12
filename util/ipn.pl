#!/usr/bin/perl

use lib 'lib';
use Data::Dumper;
use EPFarms;
use EPFarms::Transaction;
use EPFarms::User;
use strict;

my $query;
my %variable;

my $DEBUG = shift;
my ($DEBUG_ERROR, $DEBUG_INVALID, $DEBUG_VERIFIED);
my ($res_error, $res_content);

if (! $DEBUG) {
    # read post from PayPal system and add 'cmd'
    read (STDIN, $query, $ENV{'CONTENT_LENGTH'});
    $query .= '&cmd=_notify-validate';

    # post back to PayPal system to validate
    use LWP::UserAgent;
    my $ua = new LWP::UserAgent;
    #$req = new HTTP::Request 'POST','https://www.sandbox.paypal.com/cgi-bin/webscr';
    my $req = new HTTP::Request 'POST','https://www.paypal.com/cgi-bin/webscr';

    $req->content_type('application/x-www-form-urlencoded');
    $req->content($query);
    my $res = $ua->request($req);
    $res_error   = $res->is_error;
    $res_content = $res->content;

    # split posted variables into pairs
    my @pairs = split(/&/, $query);
    foreach my $pair (@pairs) {
      my ($name, $value) = split(/=/, $pair);
      $value =~ tr/+/ /;
      $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
      $variable{$name} = $value;
    }
}
else {
    %variable = (
          'verify_sign' => 'An5ns1Kso7MWUdW4ErQKJJJ4qi4-A-y.fomnpzBGn79P6lAAVO0zOmXu',
          'payer_id' => 'DWG7XF6LZTQD4',
          'residence_country' => 'US',
          'address_state' => 'DC',
          'receiver_email' => 'epfarms@epfarms.org',
          'address_status' => 'confirmed',
          'payment_type' => 'instant',
          'address_city' => 'Washington',
          'business' => 'epfarms@epfarms.org',
          'address_street' => '2130 P Street NW #509',
          'shipping' => '0.00',
          'payment_status' => 'Completed',
          'cmd' => '_notify-validate',
          'txn_type' => 'web_accept',
          'payment_fee' => '0.45',
          'address_country' => 'United States',
          'charset' => 'windows-1252',
          'payment_date' => '20:54:18 Aug 22, 2007 PDT',
          'option_selection1' => '',
          'receipt_id' => '2934-2022-5570-8595',
          'mc_fee' => '0.45',
          'payer_status' => 'unverified',
          'address_zip' => '20037',
          'custom' => '',
          'payment_gross' => '5.00',
          'txn_id' => '3X583446M01797847',
          'last_name' => 'Wilcox',
          'receiver_id' => 'DWN2DXXXYC82W',
          'item_number' => '',
          'address_country_code' => 'US',
          'payer_email' => 'awwaiid@thelackthereof.org',
          'quantity' => '1',
          'address_name' => 'Brock Wilcox',
          'tax' => '0.00',
          'item_name' => 'EPFarms Account Deposit',
          'notify_version' => '2.4',
          'mc_gross' => '5.00',
          'option_name1' => 'awwaiid',
          'mc_currency' => 'USD',
          'first_name' => 'Brock'
    );
    $DEBUG_VERIFIED = 1;
}

if ($res_error || $DEBUG_ERROR) {
  # TODO - Log error
} elsif ($res_content eq 'VERIFIED' || $DEBUG_VERIFIED) {
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
      description => 'Test Payment from paypal',
      reference_number => $txn_id,
      user => $user,
    );
    $user->add_transaction($transaction);
    $db->db->store($user);

  }

} elsif ($res_content eq 'INVALID' || $DEBUG_INVALID) {
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

