#!/usr/bin/perl

use strict;
use vars qw( $domaindb );
do "/home/awwaiid/domaindb.pl";

use EPFarms::Effin;
  
my $db = EPFarms::Effin->connect(
  'dbi:mysql:database=epfarms_effin_effin',
  'root',
  'sulipafude',
);

my $domain_service = $db->resultset('Service')->search({name => 'Domain Hosting'})->first;

foreach my $domain_name (keys %$domaindb) {
  print "Domain: $domain_name\n";
  my $username = $domaindb->{$domain_name}->{owner};
  print "\tOwner: $username\n";
  my $user = $db->resultset('User')->search({username => $username})->first;
  if(!$user) {
    print "ERROR! User '$username' not found!\n";
  }
  my $subscription = $db->resultset('Subscription')->create({
    service_id => $domain_service->service_id,
    user_id => $user->user_id,
    start_time => '2009-01-01',
  });

  my $service_detail = $db->resultset('ServiceDetail')->search({
    name => "domain_name"
  })->first;
  $db->resultset('SubscriptionDetail')->create({
    subscription_id => $subscription->subscription_id,
    service_detail_id => $service_detail->service_detail_id,
    value => $domain_name
  });

  my $service_detail = $db->resultset('ServiceDetail')->search({
    name => "is_shared"
  })->first;
  $db->resultset('SubscriptionDetail')->create({
    subscription_id => $subscription->subscription_id,
    service_detail_id => $service_detail->service_detail_id,
    value => $domaindb->{$domain_name}->{shared}
  });

  my $service_detail = $db->resultset('ServiceDetail')->search({
    name => "is_listed"
  })->first;
  $db->resultset('SubscriptionDetail')->create({
    subscription_id => $subscription->subscription_id,
    service_detail_id => $service_detail->service_detail_id,
    value => $domaindb->{$domain_name}->{listed}
  });

  my $service_detail = $db->resultset('ServiceDetail')->search({
    name => "is_subdomain"
  })->first;
  $db->resultset('SubscriptionDetail')->create({
    subscription_id => $subscription->subscription_id,
    service_detail_id => $service_detail->service_detail_id,
    value => $domaindb->{$domain_name}->{subdomain}
  });

  foreach my $service_name (keys %{ $domaindb->{$domain_name}->{services} }) {
    print "\t\tService: $service_name\n";
    my $service_detail = $db->resultset('ServiceDetail')->search({
      name => "service.$service_name"
    })->first;
    $db->resultset('SubscriptionDetail')->create({
      subscription_id => $subscription->subscription_id,
      service_detail_id => $service_detail->service_detail_id,
      value => $domaindb->{$domain_name}->{services}->{$service_name}
    });
  }
  foreach my $host_name (keys %{ $domaindb->{$domain_name}->{host} }) {
    print "\t\tHost: $host_name\n";
    my $service_detail = $db->resultset('ServiceDetail')->search({
      name => "host.$host_name"
    })->first;
    $db->resultset('SubscriptionDetail')->create({
      subscription_id => $subscription->subscription_id,
      service_detail_id => $service_detail->service_detail_id,
      value => $domaindb->{$domain_name}->{host}->{$host_name}
    });
  }
}

