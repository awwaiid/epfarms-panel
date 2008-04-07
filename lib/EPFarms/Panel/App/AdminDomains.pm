
package EPFarms::Panel::App::AdminDomains;

use Moose;
extends 'EPFarms::Panel::App';
use EPFarms::Effin;
use SOAP::Lite; # +trace => qw( debug );
use ResellerClub::DomOrderService;
use Data::Dumper;
use DateTime;

use vars qw( $username $password );

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_domains',
  title => 'Domain Admin',
  icon => 'img/famfam/icons/money.png',
  user_group => 'paneldev',
}});

sub load_domains {
  my ($self) = @_;

  do "/home/awwaiid/.epfarms-panel/resellerclub.conf";
  my $recs = [];
  my $reccount = 0;
  my $totalrecs = 0;
  my $curpage = 1;

  do {

    my $out = ResellerClub::DomOrderService::list(
      $username, # userName
      $password, # password
      #'awwaiid@thelackthereof.org', # #userName
      #'awwaiid42', # #password
      'reseller', # role
      'en', # langpref
      1, # parentid
      '', # orderId
      '', # resellerId
      '', # customerId
      '', # showChildOrders
      '', # classKey
      '', # currentStatus
      '', # description
      '', # ns
      '', # contactName
      '', # contactCompanyName
      '', # creationDTRangStart
      '', # creationDTRangEnd
      '', # endTimeRangStart
      '', # endTimeRangEnd
      100, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    # Lets just totally cheat and use a regex to turn this into a hash
    $out =~ s/^<\?xml[^>]*>//;
    $out =~ s/<Hashtable[^>]*>/{/g;
    $out =~ s/<\/Hashtable>/}\n/g;
    $out =~ s/<row name="([^"]*)">/'$1' => /g;
    $out =~ s/<\/row>/,\n/g;
    $out =~ s/ => ([^,{]+),/ => '$1',/g;

    my $data = eval $out;
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;


  } while($reccount < $totalrecs);

  return $recs;
}

sub main {
  my ($self) = @_;
  my $domains = $self->load_domains;
  do {
    my $out = "<table class=data>
      <thead>
        <tr class=header>
          <th>Domain</th>
          <th>Expires</th>
        </tr>
      </thead>";
    foreach my $domain (@$domains) {
      my $d = DateTime->from_epoch( epoch => $domain->{'orders.endtime'} || 0 );
      $out .= "<tr><td>"
        . $self->add_link($domain->{'entity.description'} => sub { $self->domain_detail($domain) })
        . "</td>"
        . "<td>"
        . ($domain->{'orders.endtime'} ? $d->ymd : $domain->{'entity.currentstatus'})
        . "</td></tr>";
    }
    $out .= "</table>";

    $self->display($out);
  } while $self->process_links;
}


sub domain_detail {
  my ($self, $domain) = @_;
  do {
    my $out = qq|
      <h2>User: $domain->{'entity.description'}</h2>
      Entry:<br>
      <pre>
    |;
    $out .= Dumper($domain);
    $out .= "</pre>";

    $self->display($out);
  } while $self->process_links;
}


1;

