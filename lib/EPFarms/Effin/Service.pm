package EPFarms::Effin::Service;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("service");
__PACKAGE__->add_columns(
  "service_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 1000,
  },
  "bill_period",
  { data_type => "ENUM", default_value => undef, is_nullable => 1, size => 5 },
  "bill_amount",
  { data_type => "FLOAT", default_value => undef, is_nullable => 1, size => 32 },
);
__PACKAGE__->set_primary_key("service_id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:C8Fzwy4BxH2Gi837URRYzQ

__PACKAGE__->has_many('details', 'EPFarms::Effin::ServiceDetail', 'service_id');

use Moose;
BEGIN {
  extends 'DBIx::Class';
  with 'EPFarms::EffinHTML';
}

1;

