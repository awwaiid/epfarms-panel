package EPFarms::Effin::ServiceDetail;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("service_detail");
__PACKAGE__->add_columns(
  "service_detail_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "service_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "is_required",
  { data_type => "ENUM", default_value => "NO", is_nullable => 0, size => 3 },
  "type",
  { data_type => "ENUM", default_value => undef, is_nullable => 1, size => 6 },
  "default_value",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("service_detail_id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qnR6YBqTNwa9qpq3hfvRAw

__PACKAGE__->belongs_to( service => 'EPFarms::Effin::Service', 'service_id' );
__PACKAGE__->has_many( subscription_details => 'EPFarms::Effin::SubscriptionDetail',
  'service_detail_id');

use Moose;
BEGIN {
  extends 'DBIx::Class';
  with 'EPFarms::EffinHTML';
}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
