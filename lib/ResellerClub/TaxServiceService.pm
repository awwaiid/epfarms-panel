package ResellerClub::TaxServiceService;
# Generated by SOAP::Lite (v0.710.08) for Perl -- soaplite.com
# Copyright (C) 2000-2006 Paul Kulchenko, Byrne Reese
# -- generated at [Mon Nov  2 20:21:42 2009]
# -- generated from file:wsdl/TaxService.wsdl
my %methods = (
getApplicableTaxes => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.tax.TaxService',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'details', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerID', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end getApplicableTaxes
getTaxRuleList => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.tax.TaxService',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end getTaxRuleList
); # end my %methods

use SOAP::Lite;
use Exporter;
use Carp ();

use vars qw(@ISA $AUTOLOAD @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter SOAP::Lite);
@EXPORT_OK = (keys %methods);
%EXPORT_TAGS = ('all' => [@EXPORT_OK]);

sub _call {
    my ($self, $method) = (shift, shift);
    my $name = UNIVERSAL::isa($method => 'SOAP::Data') ? $method->name : $method;
    my %method = %{$methods{$name}};
    $self->proxy($method{endpoint} || Carp::croak "No server address (proxy) specified")
        unless $self->proxy;
    my @templates = @{$method{parameters}};
    my @parameters = ();
    foreach my $param (@_) {
        if (@templates) {
            my $template = shift @templates;
            my ($prefix,$typename) = SOAP::Utils::splitqname($template->type);
            my $method = 'as_'.$typename;
            # TODO - if can('as_'.$typename) {...}
            my $result = $self->serializer->$method($param, $template->name, $template->type, $template->attr);
            push(@parameters, $template->value($result->[2]));
        }
        else {
            push(@parameters, $param);
        }
    }
    $self->endpoint($method{endpoint})
       ->ns($method{namespace})
       ->on_action(sub{qq!"$method{soapaction}"!});
  $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/soap/","wsdlsoap");
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.tax.TaxService","intf");
  $self->serializer->register_ns("http://xml.apache.org/xml-soap","apachesoap");
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.tax.TaxService","impl");
  $self->serializer->register_ns("http://schemas.xmlsoap.org/wsdl/","wsdl");
  $self->serializer->register_ns("http://schemas.xmlsoap.org/soap/encoding/","soapenc");
  $self->serializer->register_ns("http://www.w3.org/2001/XMLSchema","xsd");
    my $som = $self->SUPER::call($method => @parameters);
    if ($self->want_som) {
        return $som;
    }
    UNIVERSAL::isa($som => 'SOAP::SOM') ? wantarray ? $som->paramsall : $som->result : $som;
}

sub BEGIN {
    no strict 'refs';
    for my $method (qw(want_som)) {
        my $field = '_' . $method;
        *$method = sub {
            my $self = shift->new;
            @_ ? ($self->{$field} = shift, return $self) : return $self->{$field};
        }
    }
}
no strict 'refs';
for my $method (@EXPORT_OK) {
    my %method = %{$methods{$method}};
    *$method = sub {
        my $self = UNIVERSAL::isa($_[0] => __PACKAGE__)
            ? ref $_[0]
                ? shift # OBJECT
                # CLASS, either get self or create new and assign to self
                : (shift->self || __PACKAGE__->self(__PACKAGE__->new))
            # function call, either get self or create new and assign to self
            : (__PACKAGE__->self || __PACKAGE__->self(__PACKAGE__->new));
        $self->_call($method, @_);
    }
}

sub AUTOLOAD {
    my $method = substr($AUTOLOAD, rindex($AUTOLOAD, '::') + 2);
    return if $method eq 'DESTROY' || $method eq 'want_som';
    die "Unrecognized method '$method'. List of available method(s): @EXPORT_OK\n";
}

1;
