
class EPFarms::DB::Content {
  use KiokuDB::Util qw(set);

  has users => (
    is => 'rw',
    does => 'KiokuDB::Set',
    default => sub {set()}
  );
}

class EPFarms::DB {

  use KiokuDB;
  use Search::GIN::Extract::Callback;

  has db => (is => 'rw');
  has content => (
    is => 'rw',
    isa => 'EPFarms::DB::Content',
    default => sub { EPFarms::DB::Content->new },
  );
  has scope => (is => 'rw');

  method BUILD {
    my $dsn = $::dsn || "dbi:SQLite:/home/admin/epfarms-data/data.db";
    $self->db(
      KiokuDB->connect(
        "dbi:SQLite:/home/awwaiid/tmp/epfarms-data/data.db",
        #"bdb-gin:dir=/home/awwaiid/tmp/epfarms-data",
        extract => Search::GIN::Extract::Callback->new(
          extract => sub { $self->extract(@_) }
        ),
        create => 1,
      )
    );
    $self->scope( $self->db->new_scope );
    $self->content( $self->db->lookup('content'));
  }

  method extract($object, $extractor, @args) {
    if($object->can('index')) {
      print STDERR "indexing object $object\n";
      return $object->can('index')->(@args);
    } else {
      print STDERR "object $object has no index method\n";
    }
  }

  method add_user($user) {
    $self->content->users->insert($user);
  }

  sub find_user {
    my ($self, %search) = @_;
    print STDERR "Getting all users...\n";
    my @users = $self->content->users->members;
    foreach my $user (@users) {
      print STDERR "Trying user " . $user->username . "\n";
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
}

1;

