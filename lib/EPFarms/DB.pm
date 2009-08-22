
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
  use Search::GIN::Query::Manual;

  has db => (is => 'rw');
  has content => (
    is => 'rw',
    isa => 'EPFarms::DB::Content',
    default => sub { EPFarms::DB::Content->new },
  );
  has scope => (is => 'rw');

  sub BUILD {
    my $self = shift;
    my $dsn = $::dsn || "dbi:SQLite:/home/admin/epfarms-data/data.db";
    $self->db(
      KiokuDB->connect(
        $dsn,
        #"dbi:SQLite:/home/awwaiid/tmp/epfarms-data/data.db",
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
      return $object->index(@args);
    } else {
      print STDERR "object $object has no index method\n";
    }
  }

  method add_user($user) {
    $self->content->users->insert($user);
  }

  sub search {
    my ($self, %search) = @_;

    my $query = Search::GIN::Query::Manual->new(
      values => {
        %search
      },
    );
    return $self->db->search($query)->all;
  }

  sub save {
    my ($self) = @_;
    my $id = $self->db->store(content => $self->content);
    print "ID: $id\n";
  }
}

1;

