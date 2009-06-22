package EPFarms::User;

use Moose;
extends 'EPFarms';
use KiokuDB::Util qw(set);

has username => (is => 'rw', isa => 'Str');
has services => (
  is => 'rw',
  does => 'KiokuDB::Set',
  default => sub {set()}
);
has transactions => (
  is => 'rw',
  #isa => 'ArrayRef[EPFarms::Transaction]',
  does => 'KiokuDB::Set',
  default => sub {set()}
);

# These are here for now, but we might move them?
has [qw( name mysql_username external_email unixid contact )]
  => (is => 'rw', isa => 'Str');

sub add_service {
  my ($self, $service) = @_;
  $self->services->insert($service);
}

sub add_transaction {
  my ($self, $transaction) = @_;
  $self->transactions->insert($transaction);
}

sub balance {
    my ($self) = @_;
    my $total = 0;
    foreach my $txn ($self->transactions->members) {
        $total += $txn->amount;
    }
    return $total;
}

sub balance_formatted {
    my ($self) = @_;
    my $balance = $self->balance;
    return sprintf('$%.02f', $balance);
}

1;

