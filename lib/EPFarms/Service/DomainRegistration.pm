package EPFarms::Service::DomainRegistration;

use Moose;
extends 'EPFarms::Service';

has '+service_name' => ( default => 'Domain Registration' );
has '+bill_period' => ( default => 'year' );
has '+bill_amount' => ( default => -8.5 );

has domain_name => (
  is => 'rw',
  isa => 'Str',
  required => 1,
  description => {
    label => 'The Real Domain Name'
  }
);

has auto_renew => (
  is => 'rw',
  isa => 'Bool',
  default => 0
);

1;
