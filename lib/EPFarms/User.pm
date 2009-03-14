package EPFarms::User;

use Moose;
extends 'EPFarms';

has username => (is => 'rw', isa => 'Str');
has services => (is => 'rw', isa => 'ArrayRef[EPFarms::Service]', default => sub {[]});
has transactions => (
  is => 'rw',
  isa => 'ArrayRef[EPFarms::Transaction]',
  default => sub {[]}
);

# These are here for now, but we might move them?
has [qw( name mysql_username external_email unixid contact )]
  => (is => 'rw', isa => 'Str');

sub add_service {
  my ($self, $service) = @_;
  push @{$self->services}, $service;
}

sub add_transaction {
  my ($self, $transaction) = @_;
  push @{$self->transactions}, $transaction;
}

1;

