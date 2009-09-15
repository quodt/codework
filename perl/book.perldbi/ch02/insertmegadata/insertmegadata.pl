#!/usr/bin/perl -w
#
# ch02/insertmegadata/insertmegadata: Inserts a new record into the 
#                                     given megalith data file as
#                                     colon-separated data
#

### Check the user has supplied an argument to scan for
###     1) The name of the file containing the data
###     2) The name of the site to insert the data for
###     3) The location of the site
###     4) The map reference of the site
###     5) The type of site
###     6) The description of the site
die "Usage: insertmegadata"
        ." <data file> <site name> <location> <map reference> <type> <description>\n"
    unless @ARGV == 5;

my $megalithFile    = $ARGV[0];
my $siteName        = $ARGV[1];
my $siteLocation    = $ARGV[2];
my $siteMapRef      = $ARGV[3];
my $siteType        = $ARGV[4];
my $siteDescription = $ARGV[5];

### Open the data file for concatenation, and die upon failure
open MEGADATA, ">>$megalithFile"
    or die "Can't open $megalithFile for appending: $!\n";

### Create a new record
my $record = join( ":", $siteName, $siteLocation, $siteMapRef,
                        $siteType, $siteDescription );

### Insert the new record into the file
print MEGADATA "$record\n"
    or die "Error writing to $megalithFile: $!\n";

### Close the megalith data file
close MEGADATA
    or die "Error closing $megalithFile: $!";

print "Inserted record for $siteName\n";

exit;
