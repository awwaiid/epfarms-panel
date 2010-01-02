package ResellerClub;

our $username;
our $password;

# Read our resellerclub config, if any
do "$ENV{HOME}/.epfarms-panel/resellerclub.conf";

our @std_params = (
  $username, # userName
  $password, # password
  'reseller', # role
  'en', # langpref
  1, # parentid
);

sub result_to_hash {
  my $result = shift;
  print "Results before: $result\n";
  # Lets just totally cheat and use a regex to turn this into a hash
  $result =~ s/^<\?xml[^>]*>//;
  $result =~ s/<Hashtable[^>]*>/{\n/g;
  $result =~ s/<\/Hashtable>/}\n/g;
  $result =~ s/<row name="([^"]*)">/'$1' => /g;
  $result =~ s/<\/row>/,\n/g;
  $result =~ s/ => (.*?),\n/ => '$1',\n/g;

  my $data = eval $result;
  # print "Input: $result, output: " . Dumper($data);
  # print "Error: $@\n" if $@;
  return $data;
}

sub SOAP::Serializer::as_ArrayOf_xsd_int {
  my $self = shift;
  my ($value, $name, $type, $attr) = @_;
  return unless ref $value;
  return ['','',$value];
}

sub SOAP::Serializer::as_ArrayOf_xsd_string {
  my $self = shift;
  my ($value, $name, $type, $attr) = @_;
  return unless ref $value;
  return ['','',$value];
}


1;

