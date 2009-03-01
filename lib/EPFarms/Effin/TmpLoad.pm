package EPFarms::Effin::TmpLoad;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("tmp_load");
__PACKAGE__->add_columns(
  "uuid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "start",
  { data_type => "DATE", default_value => undef, is_nullable => 1, size => 10 },
  "end",
  { data_type => "DATE", default_value => undef, is_nullable => 1, size => 10 },
  "orderid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "domain",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6CPX8do/TK1Vwaf8QMlitw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
