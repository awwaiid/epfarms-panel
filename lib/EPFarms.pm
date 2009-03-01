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

