package ResellerClub::CustomerService;
# Generated by SOAP::Lite (v0.710.08) for Perl -- soaplite.com
# Copyright (C) 2000-2006 Paul Kulchenko, Byrne Reese
# -- generated at [Mon Nov  2 20:21:37 2009]
# -- generated from file:wsdl/Customer.wsdl
my %methods = (
getDetailsByCustomerEmail => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'option', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getDetailsByCustomerEmail
authenticateLoginID => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'loginID', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end authenticateLoginID
generateLoginID => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'ipAddress', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end generateLoginID
authenticateCustomerId => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'userLoginId', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end authenticateCustomerId
list => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'resellerId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'company', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'city', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'country', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerStatus', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'creationDtStart', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'creationDtEnd', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'totalReceiptStart', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'totalReceiptEnd', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'noOfRecords', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'pageNo', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderBy', type => 'impl:ArrayOf_xsd_string', attr => {}),
    ], # end parameters
  }, # end list
addCustomer => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerUserName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerPassword', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'company', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address1', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address2', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address3', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'city', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'state', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'country', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'zip', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerLangPref', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end addCustomer
createTemporaryPassword => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end createTemporaryPassword
getDetailsByCustomerId => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'option', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getDetailsByCustomerId
authenticateCustomer => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'passwd', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end authenticateCustomer
signUp => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'passwd', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'company', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address1', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address2', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address3', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'city', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'stateName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'country', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'zip', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langPref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'mobileNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'mobileNo', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end signUp
changePassword => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'newPasswd', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end changePassword
getCustomerId => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerUsername', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getCustomerId
login => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'ipAddress', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'headers', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end login
sendTemporaryPassword => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'emailAddr', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end sendTemporaryPassword
delete => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end delete
mod => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'company', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langPref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address1', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address2', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address3', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'city', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'state', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'country', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'zip', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'mobileNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'mobileNo', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end mod
modDetails => {
    endpoint => 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML',
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.user.Customer',
    parameters => [
      SOAP::Data->new(name => 'SERVICE_USERNAME', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PASSWORD', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_ROLE', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_LANGPREF', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'SERVICE_PARENTID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerUserName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'company', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langPref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address1', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address2', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'address3', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'city', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'state', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'country', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'zip', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'telNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'altTelNo', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNoCc', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'faxNo', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end modDetails
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
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.user.Customer","intf");
  $self->serializer->register_ns("http://xml.apache.org/xml-soap","apachesoap");
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.user.Customer","impl");
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
