
class EPFarms::Panel::App::AdminDomains extends EPFarms::Panel::App {

use EPFarms::DB;
use SOAP::Lite; # +trace => qw( debug );
use ResellerClub::DomOrderService;
use Data::Dumper;
use DateTime;

use vars qw( $username $password );

our $domaindb;
#do '/home/awwaiid/domaindb.pl';
eval `get-domaindb`;

has '+config' => (default => sub {{
  rank => '99',
  name => 'admin_domains',
  title => 'Domain Admin',
  icon => 'img/famfam/icons/cog.png',
  user_group => 'paneldev',
}});

sub load_domains {
  my ($self) = @_;

  do "/home/" . $self->panel->user->username . "/.epfarms-panel/resellerclub.conf";
  my $recs = [];
  my $reccount = 0;
  my $totalrecs = 0;
  my $curpage = 1;

  do {

    my $out = ResellerClub::DomOrderService::list(
      $username, # userName
      $password, # password
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
  my ($username, $password) = $self->get_mysql_auth;
  return unless $username;
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );
  do {
    my $out = "<table class=data cellspacing=0 cellpadding=3>
      <thead>
        <tr class=header>
          <th>Domain</th>
          <th>Status</th>
          <th>Expires</th>
          <th>Owner</th>
          <th>Balance</th>
        </tr>
      </thead>";
    foreach my $domain (@$domains) {
      next if $domain->{'entity.currentstatus'} eq 'Deleted';
      my $username = $domaindb->{$domain->{'entity.description'}}->{owner};
      my $user = $db->resultset('Users')->find({usr_nname => $username});
      my $balance = "&nbsp;";
      if($user) {
        $balance = $user->balance_formatted;
      }
      my $d = DateTime->from_epoch( epoch => $domain->{'orders.endtime'} || 0 );
      $out .= "<tr><td>"
        . $self->add_link($domain->{'entity.description'} => sub { $self->domain_detail($domain) })
        . "</td>"
        . "<td>"
        . $domain->{'entity.currentstatus'}
        . "</td>"
        . "<td>"
        . ($domain->{'orders.endtime'} ? $d->ymd : $domain->{'entity.currentstatus'})
        . "</td>"
        . "<td>"
        . $domaindb->{$domain->{'entity.description'}}->{owner}
        . "</td>"
        . "<td>"
        . $balance
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
      <h2>Domain: $domain->{'entity.description'}</h2>
      Entry:<br>
      <pre>
    |;
    $out .= Dumper($domain);
    $out .= "</pre>";
    $out .= "DomainDB: <pre>";
    $out .= Dumper($domaindb->{$domain->{'entity.description'}});
    $out .- "</pre>";
    $out .= $self->add_link('Renew Domain' => sub { $self->renew_domain($domain) });

    $self->display($out);
  } while $self->process_links;
}

sub renew_domain {
  my ($self, $domain) = @_;
  $self->display("Sure... I'll get right on that.");
}

}

