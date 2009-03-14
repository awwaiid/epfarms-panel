package EPFarms::Transaction;

use Moose;
use Moose::Util::TypeConstraints;
use DateTime;
extends 'EPFarms';

has timestamp => (is => 'rw', isa => 'DateTime', default => sub { DateTime->now }, coerce => 1);
has amount => (is => 'rw', isa => 'Num');
has description => (is => 'rw', isa => 'Str');
has reference_number => (is => 'rw', isa => 'Str');
has user => (is => 'rw', isa => 'EPFarms::User', weak_ref => 1);
has service => (is => 'rw', isa => 'EPFarms::Service', weak_ref => 1);

class_type 'DateTime';
coerce 'DateTime'
  => from 'Str'
  => via {
    require DateTime::Format::DateManip;
    DateTime::Format::DateManip->parse_datetime($_)
  };

1;

