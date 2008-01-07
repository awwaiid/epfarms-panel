package EPFarms::Effin::Methods;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("methods");
__PACKAGE__->add_columns(
  "met_text",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "met_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "met_createdon",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
  "met_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "met_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "met_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("met_uid");


# Created by DBIx::Class::Schema::Loader v0.04003 @ 2007-12-30 17:11:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1HX+upd/9YBrCcoW1GPz+A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
