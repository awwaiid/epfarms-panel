package EPFarms::DB::Transaction;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("transaction");
__PACKAGE__->add_columns(
  "transaction_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "txndate",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "amount",
  { data_type => "FLOAT", default_value => undef, is_nullable => 1, size => 32 },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 200,
  },
);
__PACKAGE__->set_primary_key("transaction_id");


# Created by DBIx::Class::Schema::Loader v0.04003 @ 2007-12-08 23:37:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0oaedj7hBOYn5A4L6XVQrA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
