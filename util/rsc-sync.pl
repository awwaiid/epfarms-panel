#!/usr/local/bin/perl

use 5.010;
use strict;
use lib '../lib';
use EPFarms;
#use SOAP::Lite +trace => qw( debug );
use SOAP::Lite;
use ResellerClub;
use ResellerClub::FundService;
use ResellerClub::DomOrderService;
use ResellerClub::OrderService;
use DateTime;
use Data::Dumper;
use EPFarms::Service::DomainRegistration;
use EPFarms::Transaction;

use vars qw( $username $password );
do "/home/awwaiid/.epfarms-panel/resellerclub.conf";

our $domaindb;
do "/home/awwaiid/tmp/epfarms/domaindb.pl";

# Kill existing registration/transfer/renewal transactions

sub get_domain_order_id {
  my $domain_name = shift;
  my $productkey = shift;
  if(!$productkey) {
    given($domain_name) {
      when (/\.org$/) { $productkey = 'domorg' }
      when (/\.com$/) { $productkey = 'domcmo' }
      when (/\.net$/) { $productkey = 'domtin' }
    }
  }
  my $order_id = ResellerClub::DomOrderService::getOrderIdByDomain(
    @ResellerClub::std_params,
    $domain_name, # java.lang.String domainName,
    $productkey, # java.lang.String productkey
  );
}

sub get_order_actions {
  my $entityId = shift;
  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];
  my $curpage = 1;
  my $service = ResellerClub::OrderService->new;
  $service->readable(1);

  do {
    my $out = $service->listArchivedActions(
      @ResellerClub::std_params,
      [], # int[] eaqId,
      [$entityId], # int[] entityId,
      [], # int[] entitytypeid,
      [], # java.lang.String[] actionStatus,
      ['AddNewDomain','RenewDomain','AddTransferDomain'], # java.lang.String[] actionType,
      10, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    my $data = ResellerClub::result_to_hash($out);
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;
    # print "Recs: " . (scalar @$recs) . "\n";
  } while($reccount < $totalrecs);
  return $recs;
}


sub get_all_orders {
  # my $dom_order = ResellerClub::DomOrderService->new;
  # $dom_order->readable(1);

  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];

  my $curpage = 1;
  # my $fromDate = DateTime->new( year => 2000 )->epoch;
  # my $toDate   = DateTime->now->epoch;
  # print STDERR "From: $fromDate\nTo: $toDate\n";
  
  my $service = ResellerClub::DomOrderService->new;
  $service->readable(1);

  do {

    my $out = $service->list(
      @ResellerClub::std_params,
      '', # int[] orderId,
      '', # int[] resellerId,
      '', # int[] customerId,
      '', # boolean showChildOrders,
      '', # java.lang.String[] classKey,
      '', # java.lang.String[] currentStatus,
      '', # java.lang.String description,
      '', # java.lang.String[] ns,
      '', # java.lang.String contactName,
      '', # java.lang.String contactCompanyName,
      '', # java.lang.String creationDTRangStart,
      '', # java.lang.String creationDTRangEnd,
      '', # java.lang.String endTimeRangStart,
      '', # java.lang.String endTimeRangEnd,
      100, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    my $data = ResellerClub::result_to_hash($out);
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};


    push @$recs, values %$data;

  } while($reccount < $totalrecs);

  return $recs;
}

my $all_dom_orders = get_all_orders();
#print Dumper($all_dom_orders);

my $db = EPFarms::DB->new;

my $price_jump_date = DateTime->new( year => 2009, month => 1, day => 1 );

my $scope = $db->db->new_scope;

foreach my $domain (@$all_dom_orders) {

  $db->db->txn_do(sub {

  # print "domain dump: " . Dumper($domain) . "\n";
  print "Domain broken " . Dumper($domain) unless $domain->{'orders.creationtime'} && $domain->{'orders.endtime'};
  next unless $domain->{'orders.creationtime'} && $domain->{'orders.endtime'};
  my $start = DateTime->from_epoch( epoch => $domain->{'orders.creationtime'} );
  my $end   = DateTime->from_epoch( epoch => $domain->{'orders.endtime'} );
  print "Dom: $domain->{'entity.description'}\t$start\t$end\n";
  my $domain_name = $domain->{'entity.description'};

  # Try to look up owner from domaindb.pl
  my $owner;
  if($domaindb->{$domain_name}) {
    my $owner_username = $domaindb->{$domain_name}->{owner};
    print "Owner: $owner_username\n";
    ($owner) = $db->search( username => $owner_username );

    if(!$owner) {
      print "OWNER OBJECT NOT FOUND\n";
    } else {
      # print "Owner txns: " . (join ',',map { $_->reference_number } $owner->transactions->members) . "\n";
    }
  } else {
    print "OWNER NOT FOUND!\n";
  }

  my @domain_regs = $db->search(domain_name => $domain_name);
  my $domain_obj;
  if(! @domain_regs) {
    print "Service not found, creating a new one...\n";
    $domain_obj = EPFarms::Service::DomainRegistration->new(
      domain_name => $domain->{'entity.description'},
    );
    $db->db->store($domain_obj);
  } else {
   # print " ... found\n";
   $domain_obj = $domain_regs[0];
  }


  # OK, so now we have our domain!

  my $order_id = $domain->{'orders.orderid'};
  my $actions = get_order_actions($order_id);
  foreach my $action (@$actions) {
    #print "Action:" . Dumper($action);
    # print "Owner txnsY: " . (join ',',map { $_->reference_number } $owner->transactions->members) . "\n" if $owner;
    my $txn_id = $action->{eaqid};
    my $start_time = DateTime->from_epoch( epoch => $action->{actionadded} );
    # print $action->{actiontype} . "\t$start_time\t$txn_id\n";
    my @txns = $db->search( reference_number => $txn_id );
    # my @txns = $db->filter_all( sub {
      # ref $_ eq 'EPFarms::Transaction'
      # && $_->reference_number eq $txn_id } );
    my $txn;
    if(!@txns) {
      # print "Dom: $domain->{'entity.description'}\t$start\t$end\n";
      print "Transaction not found. Creating a new one...\n";
      $txn = EPFarms::Transaction->new(
        timestamp => $start_time,
        description => $action->{actiontypedesc},
        amount => $start_time < $price_jump_date ? -7.5 : -8.5,
        reference_number => $txn_id,
        service => $domain_obj,
      );
      $db->db->store($txn);
    } else {
      #print " ... txn found\n";
      $txn = shift @txns;
    }

    # See if the owner already has this transaction
    if($owner) {
      my @txns = $owner->transactions->members;
      # print "Owner txnsZ: " . (join ',',map { $_->reference_number } $owner->transactions->members) . "\n";
      if(grep { $_->reference_number eq $txn->reference_number } @txns) {
        # print "TXN found, all done!\n";
      } else {
        # print "Dom: $domain->{'entity.description'}\t$start\t$end\n";
        print "Adding txn for user!\n";
        $owner->add_transaction($txn);
        $db->db->store($owner);
        # $db->db->store($owner->transactions);
        # $db->db->store($txn);
        print "Added " . $txn->reference_number . ", now have:\n";
        print "Owner txns: " . (join ',',map { $_->reference_number } $owner->transactions->members) . "\n";
      }
    }
    # print "Owner txnsX: " . (join ',',map { $_->reference_number } $owner->transactions->members) . "\n" if $owner;

  }


  # $order_id = get_domain_order_id('epfarms.net');
  # print "epfarms.net order id $order_id\n";

  });

}


