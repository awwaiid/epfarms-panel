#!/usr/bin/perl

use strict;
use v5.10;

use EPFarms::Effin;
  
my $db = EPFarms::Effin->connect(
  'dbi:mysql:database=epfarms_effin_effin',
  'root',
  'sulipafude',
);

my $domain_service = $db->Service({name => 'Domain Hosting'})->first;

my $command = shift @ARGV;

given ($command) {
  when ('show') { show() }
  default {
    print qq{

domain show domain 'domainname'
domain show user 'username'

}}}

sub show {
  my $type = shift @ARGV;
  if($type eq 'domain') {
    my $domain = shift @ARGV;
    show_domain($domain);
  } elsif($type eq 'user') {
    my $username = shift @ARGV;
    show_user($username);
  }
}

sub show_domain {
  my ($domainname) = @_;

  # Find the subscription for this domain
  my $subscription =
    $domain_service
    ->details({ name => 'domain_name' })
    ->first
    ->subscription_details({ value => $domainname })
    ->first
    ->subscription;
  my $domain = {};
  foreach my $detail ($subscription->details) {
    print $detail->service_detail->name . "\t= " . $detail->value . "\n";
    $domain->{$detail->service_detail->name} = $detail->value;
  }
  return $domain;
}

sub get_subscription_details {
  my ($subscription) = @_;
  my $hash = {};
  foreach my $detail ($subscription->details) {
    $hash->{$detail->service_detail->name} = $detail->value;
  }
  return $hash;
}

sub show_user {
  my ($username) = @_;
  my $user = $db->User({username => $username})->first;
  my (@subscriptions) = $user->subscriptions;
  foreach my $subscription (@subscriptions) {
    my $service = $subscription->service;
    print "@{[ $service->name ]}, \$@{[ $service->bill_amount ]}/@{[ $service->bill_period ]}, last billed @{[ $subscription->last_bill_time ]}\n";
    my (@subscription_details) = $subscription->details;
    foreach my $detail (@subscription_details) {
      my $service_detail = $detail->service_detail;
      print "\t@{[ $service_detail->name ]}: @{[ $detail->value ]}\n";
    }
  }
}

