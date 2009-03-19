package EPFarms::DB::Content;
use Moose;
use KiokuDB::Util qw(set);

has users => (
  is => 'rw',
  does => 'KiokuDB::Set',
  default => sub {set()}
);

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
  $self->content( $self->db->lookup('content'));
}

sub add_user {
  my ($self, $user) = @_;
  $self->content->users->insert($user);
}

sub find_user {
  my ($self, %search) = @_;
  my @users = $self->content->users->members;
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
  my $id = $self->db->store(content => $self->content);
  print "ID: $id\n";
}

1;

