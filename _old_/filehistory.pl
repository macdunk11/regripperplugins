#-----------------------------------------------------------
# filehistory.pl
# Get filehistory settings
#
# Change history
#   20120620 - updated/modified by H. Carvey
#   20120607 - created by K. Johnson
#
# References
#   This RegRipper plugin was created based on research I have done on the FileHistory Feature of Windows 8. 
#   http://randomthoughtsofforensics.blogspot.com/
# 
# FileHistoy Plugin copyright 2012 K. Johnson
#-----------------------------------------------------------
package filehistory;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 0,
              osmask        => 22,
              version       => 20120620);

sub getConfig{return %config}
sub getShortDescr {
    return "Gets filehistory settings";    
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
    my $class = shift;
    my $ntuser = shift;
    ::logMsg("Launching filehistory v.".$VERSION);
    my $reg = Parse::Win32Registry->new($ntuser);
    my $root_key = $reg->get_root_key;

    my $key_path = "Software\\Microsoft\\Windows\\CurrentVersion\\FileHistory";
    my $key;
    if ($key = $root_key->get_subkey($key_path)) {
        ::rptMsg($key_path);
        ::rptMsg("LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
        ::rptMsg("");
        my @vals = $key->get_list_of_values();
        
        if (scalar(@vals) > 0) {
            foreach my $v (@vals) {
                
# we need to get our protecteduptotime here, this is the last time that the machine backed up data. 

                if ($v->get_name() eq "ProtectedUpToTime") {
                    my @t = unpack("VV",$v->get_data());
                    my $pft = ::getTime($t[0],$t[1]);
                    ::rptMsg("  ProtectedUpToTime = ".gmtime($pft)." (UTC)");    
                }
                
                if ($v->get_name() eq "ReassociationPerformed") {
                    ::rptMsg(sprintf "%-20s 0x%x","ReassociationPerformed",$v->get_data());
                }
# can we restore this data. 1 is true
             
                if ($v->get_name() eq "RestoreAllowed") {
                    ::rptMsg(sprintf "%-20s 0x%x","RestoreAllowed",$v->get_data());
                }
                
                if ($v->get_name() eq "SearchRebuildRequired") {
                    ::rptMsg(sprintf "%-20s 0x%x","SearchRebuildRequired",$v->get_data());
                }
                
#If the target has changed. I have yet to see this populated. If you do run across this please let me know. 
                if ($v->get_name() eq "TargetChanged") {
                    ::rptMsg(sprintf "%-20s 0x%x","TargetChanged",$v->get_data());
                }
            }
        }
        else {
            ::rptMsg($key_path." has no values.");
            ::rptMsg("File History may not be configured for this user.");
        }
    }
    else {
        ::rptMsg($key_path." not found.");
    }
}

1;