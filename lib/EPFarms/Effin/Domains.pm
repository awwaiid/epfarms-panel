package EPFarms::Effin::Domains;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("domains");
__PACKAGE__->add_columns(
  "dmn_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "dmn_usr_uid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "dmn_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "dmn_efregisterd",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 4 },
  "dmn_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 4 },
  "dmn_createdon",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
  "dmn_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "dmn_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("dmn_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sDrQ6BlsJs+KNnfC7+Ej9w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
