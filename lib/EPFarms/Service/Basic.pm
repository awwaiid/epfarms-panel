package EPFarms::Service::Basic;

use Moose;
extends 'EPFarms::Service';

has '+service_name' => ( default => 'Basic' );
has '+bill_period' => ( default => sub { 'month' } );
has '+bill_amount' => ( default => -2 );

1;

