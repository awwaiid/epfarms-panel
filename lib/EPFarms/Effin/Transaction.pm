package EPFarms::Effin::Transaction;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("transaction");
__PACKAGE__->add_columns(
  "transaction_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "transaction_time",
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
    size => 100,
  },
  "reference_number",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "subscription_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("transaction_id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/PBSAn52yJTZiDNlwSMwTw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
