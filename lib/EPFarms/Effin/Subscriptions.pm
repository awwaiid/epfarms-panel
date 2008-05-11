package EPFarms::Effin::Subscriptions;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("subscriptions");
__PACKAGE__->add_columns(
  "sub_usr_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "sub_ser_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "sub_startdate",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "sub_termdate",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "sub_orderid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "sub_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "sub_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "sub_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "sub_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "sub_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("sub_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7dj+NVOlsKZTwIUiSJ081A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
