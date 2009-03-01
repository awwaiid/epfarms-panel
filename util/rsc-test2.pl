#!/usr/local/bin/perl

use strict;
use lib '../lib';

{
  package ResellerClub::DomOrderService;
  use base 'SOAPService';

  use vars qw( $username $password );
  do "/home/awwaiid/.epfarms-panel/resellerclub.conf";

  sub new {
    my ($class, @params) = @_;
    my $ns = {
      soap => "http://schemas.xmlsoap.org/soap/envelope/",
      impl => "com.logicboxes.foundation.sfnb.order.DomOrder",
      wsdlsoap => "http://schemas.xmlsoap.org/wsdl/soap/",
      apachesoap => "http://xml.apache.org/xml-soap",
      wsdl => "http://schemas.xmlsoap.org/wsdl/",
      soapenc => "http://schemas.xmlsoap.org/soap/encoding/",
    };
    my $self = $class->SUPER::new(
      ns => $ns,
      no_header => 1,
      proxy => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
      namespace => "com.logicboxes.foundation.sfnb.order.DomOrder",
      @params
    );
    $self->{service}->autotype(1);
    $self->{service}->on_action(sub { '""' });
    return $self;
  }

  sub list {
    my ($self, %params) = @_;
    my $int_array = { type => 'impl:ArrayOf_xsd_int' };
    my $string_array = { type => 'impl:ArrayOf_xsd_string' };
    my $boolean = { type => 'xsd:boolean' };
    my @params = (
      userName => $username, # userName
      password => $password, # password
      role => 'reseller',
      langpref => 'en',
      parentid => 1,
      orderId => $int_array => '',
      resellerId => $int_array => '',
      customerId => $int_array => '',
      showChildOrders => $boolean => 0,
      classKey => $string_array => '',
      currentStatus => $string_array => '',
      description => '',
      ns => $string_array => '',
      contactName => '',
      contactCompanyName => '',
      creationDTRangStart => '',
      creationDTRangEnd => '',
      endTimeRangStart => '',
      endTimeRangEnd => '',
      numOfRecordPerPage => 100,
      pageNum => 1,
      orderBy => $string_array => '',
    );
    return $self->soap_call(list => [ %params ])->result;
  }

  1;
      # userName => $username, # userName
      # password => $password, # password
      # role => 'reseller',
      # langpref => 'en',
      # parentid => 1,
      # orderId => {type => "impl:ArrayOf_xsd_int"} => '',
      # resellerId => {type => "impl:ArrayOf_xsd_int"} => '',
      # customerId => {type => "impl:ArrayOf_xsd_int"} => '',
      # showChildOrders => {type => "xsd:boolean"} => 0,
      # classKey => {type => "impl:ArrayOf_xsd_string"} => '',
      # currentStatus => {type => "impl:ArrayOf_xsd_string"} => '',
      # description => '',
      # ns => {type => "impl:ArrayOf_xsd_string"} => '',
      # contactName => '',
      # contactCompanyName => '',
      # creationDTRangStart => '',
      # creationDTRangEnd => '',
      # endTimeRangStart => '',
      # endTimeRangEnd => '',
      # numOfRecordPerPage => 100,
      # pageNum => 1,
      # orderBy => {type => "impl:ArrayOf_xsd_string"} => '',

}

sub get_all_orders {
  my $rc = ResellerClub::DomOrderService->new;
  #my $domains = $rc->list( pageNum => 1 );
  #return $domains;

  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];

  my $curpage = 1;

  do {

    my $out = $rc->list( pageNum => $curpage );

    # Lets just totally cheat and use a regex to turn this into a hash
    $out =~ s/^<\?xml[^>]*>//;
    $out =~ s/<Hashtable[^>]*>/{/g;
    $out =~ s/<\/Hashtable>/}\n/g;
    $out =~ s/<row name="([^"]*)">/'$1' => /g;
    $out =~ s/<\/row>/,\n/g;
    $out =~ s/ => ([^,{]+),/ => '$1',/g;

    my $data = eval $out;
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;


  } while($reccount < $totalrecs);

  return $recs;
}

my $recs = get_all_orders;
use Data::Dumper;
print Dumper($recs);

print "Record count: " . (scalar @$recs) . "\n";
exit;

my $domains = {};

foreach my $row (@$recs) {
  $domains->{$row->{'entity.description'}}->{$row->{'entity.currentstatus'}}++;
}

print "Active:\n";
my $active_count = 0;
foreach my $d (sort keys %$domains) {
  print "$d\t$domains->{$d}->{Active}\n" if $domains->{$d}->{Active};
  $active_count++ if $domains->{$d}->{Active};
}

print "Deleted:\n";
my $deleted_count = 0;
foreach my $d (sort keys %$domains) {
  print "$d\t$domains->{$d}->{Deleted}\n" if $domains->{$d}->{Deleted};
  $deleted_count++ if $domains->{$d}->{Deleted};
}

print "Active count: $active_count\n";
print "Deleted count: $deleted_count\n";


