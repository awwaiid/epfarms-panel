package EPFarms::Effin::MyUsers;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("my_users");
__PACKAGE__->add_columns(
  "usr_efid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "usr_nname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_isadmin",
  { data_type => "VARCHAR", default_value => undef, is_nullable => 1, size => 1 },
  "usr_deleted",
  { data_type => "BIT", default_value => undef, is_nullable => 1, size => undef },
  "usr_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_uid",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
  "usr_mysql_username",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_external_email",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6k4nEB1JHTF+KxAwAjBRgw

__PACKAGE__->set_primary_key("usr_uid");

# You can replace this text with custom content, and it will be preserved on regeneration
1;
