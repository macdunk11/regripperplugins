#-----------------------------------------------------------
#wpa.pl
#
# History:
#  20120903 - created
#
# References:
#  
# 
# copyright 2012 Quantum Analytics Research, LLC
# Author: H. Carvey, keydet89@yahoo.com
#-----------------------------------------------------------
package wpa;
use strict;

my %config = (hive          => "System",
							hivemask      => 4,
							output        => "report",
							category      => "",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 0,
              osmask        => 31,  #XP - Win7
              version       => 20120903);

sub getConfig{return %config}
sub getShortDescr {
	return "Unknown at this point";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();
my %files;
my @temps;

sub pluginmain {
	my $class = shift;
	my $hive = shift;
	::logMsg("Launching wpa v.".$VERSION);
	my $reg = Parse::Win32Registry->new($hive);
	my $root_key = $reg->get_root_key;
# First thing to do is get the ControlSet00x marked current...this is
# going to be used over and over again in plugins that access the system
# file
	my $wpa;
	my $key_path = 'WPA';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		my @subkeys = $key->get_list_of_subkeys();
		if (scalar(@subkeys) > 0) {
			foreach my $s (@subkeys) {
				my $name = $s->get_name();
				my $lw   = $s->get_timestamp();
				::rptMsg($name);
				::rptMsg("LastWrite: ".gmtime($lw));
				eval {
					my $guid = parseGUID($s->get_value("")->get_data());
					::rptMsg("GUID: ".$guid);
					my $time = $s->get_value("Time")->get_data();
					$time =~ s/\00//g;
					::rptMsg("Time: ".$time);
					
				};
				::rptMsg("");
			}
		}
		else {
			::rptMsg($key_path." has no subkeys.");
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}
}

#-----------------------------------------------------------
# parseGUID()
# Takes 16 bytes of binary data, returns a string formatted
# as an MS GUID.
#-----------------------------------------------------------
sub parseGUID {
	my $data     = shift;
  my $d1 = unpack("V",substr($data,0,4));
  my $d2 = unpack("v",substr($data,4,2));
  my $d3 = unpack("v",substr($data,6,2));
	my $d4 = unpack("H*",substr($data,8,2));
  my $d5 = unpack("H*",substr($data,10,6));
  return sprintf "{%08x-%x-%x-$d4-$d5}",$d1,$d2,$d3;
}
1;