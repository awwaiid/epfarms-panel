package EPFarms::User;

use Moose;
extends 'EPFarms';

has username => (is => 'rw', isa => 'Str');
has services => (is => 'rw', isa => 'ArrayRef[EPFarms::Service]', default => sub {[]});

1;

