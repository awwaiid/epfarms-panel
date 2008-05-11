package EPFarms::Effin::UnixAccounts;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("unix_accounts");
__PACKAGE__->add_columns(
  "unx_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "unx_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "unx_uuid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "unx_ugid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "unx_sub_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "unx_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "unx_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "unx_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "unx_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("unx_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EkVSmmAC731IVXm9/x3juw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
