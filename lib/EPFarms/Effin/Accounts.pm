package EPFarms::Effin::Accounts;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("accounts");
__PACKAGE__->add_columns(
  "acc_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "acc_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "acc_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "acc_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "acc_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "acc_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("acc_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LdXCRqxfSDXZbIpq7iLdQw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
