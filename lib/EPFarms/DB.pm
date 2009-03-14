package EPFarms::DB::Content;
use Moose;

has users => (is => 'rw', isa => 'ArrayRef[EPFarms::User]', default => sub { [] });

package EPFarms::DB;

use Moose;
use KiokuDB;

has db => (is => 'rw');
has content => (
  is => 'rw',
  isa => 'EPFarms::DB::Content',
  default => sub { EPFarms::DB::Content->new },
);
has scope => (is => 'rw');

sub BUILD {
  my $self = shift;
  $self->db(
    KiokuDB->connect("bdb:dir=/tmp/data", create => 1)
  );
  $self->scope( $self->db->new_scope );
  $self->content( $self->db->root_set->all );
}

sub add_user {
  my ($self, $user) = @_;
  push @{$self->content->users}, $user;
}

sub find_user {
  my ($self, %search) = @_;
  my @users = @{ $self->content->users };
  foreach my $user (@users) {
    my $found = 1;
    foreach my $search_key (keys %search) {
      if($user->$search_key() ne $search{$search_key}) {
        $found = 0;
        last;
      }
    }
    return $user if $found;
  }
  return undef;
}

sub save {
  my ($self) = @_;
  $self->db->store($self->content);
}

1;

