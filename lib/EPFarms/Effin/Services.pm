package EPFarms::Effin::Services;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("services");
__PACKAGE__->add_columns(
  "ser_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 100,
  },
  "ser_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 1000,
  },
  "ser_cost",
  { data_type => "FLOAT", default_value => 0, is_nullable => 0, size => 32 },
  "ser_mofreq",
  { data_type => "INT", default_value => 1, is_nullable => 0, size => 11 },
  "ser_available",
  { data_type => "TINYINT", default_value => 1, is_nullable => 0, size => 1 },
  "ser_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "ser_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "ser_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "ser_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "ser_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("ser_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ERoMwabp4lQ7LCEJEdIcIg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
