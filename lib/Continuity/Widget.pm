package Continuity::Widget;

use Moose;
use Coro::Generator;
use Data::UUID;

has 'cont' => (is => 'rw');
has 'request' => (is => 'rw');
has 'id' => (
  is      => 'ro', 
  isa     => 'Str', 
  default => sub { Data::UUID->new->create_str }
);
has 'output' => (is => 'rw',   isa => 'Str', default => '');
has 'input' => (is => 'rw', defualt => sub {{}});

sub process {
  my ($self, $input) = @_;
  $self->input($input);
  $self->{cont} ||= generator { while(1) { eval { $self->main } } };
  $self->{cont}->();
  return $self->output;
}

sub next {
  my ($self, $output) = @_;
  $self->output($output);
  yield;
}

1;

