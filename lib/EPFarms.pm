
# This preamble stuff is mostly to make it easy to use EPFarms code.

use strict;
# Everybody loves MooseX::Declare, right?!
use everywhere 'MooseX::Declare; use 5.010',
  matching => '^EPFarms',
  use_here => 1;
use EPFarms::DB;

package EPFarms;

use metaclass 'MooseX::MetaDescription::Meta::Class' => (
  attribute_metaclass => 'MooseX::MetaDescription::Meta::Attribute::Ordered',
);

use Moose;
with 'MooseX::Renderer::Continuity::HTML';

# Do this to mass-set class metadescriptions
# __PACKAGE__->metadescription({
  # fish => 'food'
# });

sub metadescription {
  my ($class, $d) = @_;
  foreach my $k (keys %$d) {
    __PACKAGE__->meta->description->{$k} = $d->{$k};
  }
}


1;

