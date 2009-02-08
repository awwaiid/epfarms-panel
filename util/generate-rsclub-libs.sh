#!/bin/sh

# Clear out the existing ones
rm ../lib/ResellerClub/*.pm

# Make the stubs
for i in wsdl/*.wsdl ; do stubmaker.pl -d ../lib/ResellerClub file:$i ; done

# Fix the namespaces
perl -p -i -e 's/package /package ResellerClub::/' ../lib/ResellerClub/*.pm

