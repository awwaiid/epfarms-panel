package ResellerClub::DomOrderService;

my $service_url = 'http://demo.myorderbox.com/anacreon/servlet/APIv3-XML';

# Generated by SOAP::Lite (v0.71) for Perl -- soaplite.com
# Copyright (C) 2000-2006 Paul Kulchenko, Byrne Reese
# -- generated at [Thu Feb 28 23:50:55 2008]
# -- generated from file:wsdl/DomOrder.wsdl
my %methods = (
addChildNameServer => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'cns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ipAddress', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end addChildNameServer
bulkModifyByDomainName => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainNames', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end bulkModifyByDomainName
add => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end add
addTransferDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'addParamList', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'nameServersList', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'enablePrivacyProtection', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'validate', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'extraInfo', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end addTransferDomain
getOrderIdByDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'productkey', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getOrderIdByDomain
isTransferRequestValid => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainName', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end isTransferRequestValid
modifyChildNameServerIp => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'cns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'oldIp', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'newIp', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end modifyChildNameServerIp
getDetails => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'option', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getDetails
renewDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end renewDomain
checkAvailabilityMultiple => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainNames', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'tlds', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'suggestAlternative', type => 'xsd:boolean', attr => {}),
    ], # end parameters
  }, # end checkAvailabilityMultiple
getDetailsByDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'option', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end getDetailsByDomain
changePrivacyProtectionStatus => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'lockerId', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'orderID', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'newIsPrivacyProtected', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'reason', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end changePrivacyProtectionStatus
checkNameServer => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'nameServer', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'productKeys', type => 'impl:ArrayOf_xsd_string', attr => {}),
    ], # end parameters
  }, # end checkNameServer
deleteChildNameServerIp => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'cns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ipAddress', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end deleteChildNameServerIp
list => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'resellerId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'showChildOrders', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'classKey', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'currentStatus', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'description', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'contactName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'contactCompanyName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'creationDTRangStart', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'creationDTRangEnd', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'endTimeRangStart', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'endTimeRangEnd', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'numOfRecordPerPage', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'pageNum', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderBy', type => 'impl:ArrayOf_xsd_string', attr => {}),
    ], # end parameters
  }, # end list
validateDomainRegistrationParams => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end validateDomainRegistrationParams
modifyDomainSecret => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'newSecret', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end modifyDomainSecret
modifyContact => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end modifyContact
bulkAdd => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domains', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'noOfYears', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end bulkAdd
bulkAddTransferDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end bulkAddTransferDomain
registerDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'addParamList', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'nameServersList', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'enablePrivacyProtection', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'validate', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'extraInfo', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end registerDomain
del => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end del
modifyNameServer => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'nsHash', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end modifyNameServer
validateDomainTransferParams => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end validateDomainTransferParams
namesuggestion => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainname', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'hyphenAllowed', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'numberAllowed', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'domainNameLen', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'noofResults', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'arrTlds', type => 'impl:ArrayOf_xsd_string', attr => {}),
    ], # end parameters
  }, # end namesuggestion
addWithoutValidation => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end addWithoutValidation
bulkModifyByCustomerId => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerID', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'resellerId', type => 'impl:ArrayOf_xsd_int', attr => {}),
      SOAP::Data->new(name => 'domainNames', type => 'impl:ArrayOf_xsd_string', attr => {}),
      SOAP::Data->new(name => 'ns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end bulkModifyByCustomerId
modifyChildNameServerName => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'orderId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'oldCns', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'newCns', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end modifyChildNameServerName
addTransferDomainWithoutvalidation => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
    ], # end parameters
  }, # end addTransferDomainWithoutvalidation
transferDomain => {
    endpoint => $service_url,
    soapaction => '',
    namespace => 'com.logicboxes.foundation.sfnb.order.DomOrder',
    parameters => [
      SOAP::Data->new(name => 'userName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'role', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'langpref', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'parentid', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'domainHash', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'registrantContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'adminContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'techContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'billingContactId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'customerId', type => 'xsd:int', attr => {}),
      SOAP::Data->new(name => 'invoiceOption', type => 'xsd:string', attr => {}),
    ], # end parameters
  }, # end transferDomain
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
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.order.DomOrder","intf");
  $self->serializer->register_ns("http://xml.apache.org/xml-soap","apachesoap");
  $self->serializer->register_ns("com.logicboxes.foundation.sfnb.order.DomOrder","impl");
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
