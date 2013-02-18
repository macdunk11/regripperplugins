#-----------------------------------------------------------
# Google_Earth_Searches.pl
#   Plugin for Registry Ripper, NTUSER.DAT edition - gets the Google Earth Searches a user executed 
#
# Change history
#   20120810 Script created
# 
# Note: This plugin was created using most of the code from typedurs.pl
#
# 
#########################COPYRIGHT INFORMATION############################
#Copyright (C) 2012 Doug Koster   douglas.koster@TASC.com                #
#This program is free software: you can redistribute it and/or modify    #
#it under the terms of the GNU General Public License as published by    #
#the Free Software Foundation, either version 3 of the License, or       #
#(at your option) any later version.                                     #
                                                                         #
#This program is distributed in the hope that it will be useful,         #
#but WITHOUT ANY WARRANTY; without even the implied warranty of          #
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
#GNU General Public License for more details.                            #
                                                                         #
#You should have received a copy of the GNU General Public License       #
#along with this program.  If not, see http://www.gnu.org/licenses/.     #
#########################COPYRIGHT INFORMATION############################
#-----------------------------------------------------------
package Google_Earth_Searches;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              osmask        => 22,
              version       => 20120810);

sub getConfig{return %config}
sub getShortDescr {
	return "Returns contents of user's Google Earth Plus Search key.";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching Google_Earth_Searches v.".$VERSION);
    ::rptMsg("Google_Earth_Searches v.".$VERSION." Author: Doug Koster TASC"); 
    ::rptMsg("(".getHive().") ".getShortDescr()."\n"); 

	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;
	
	my $key_path = 'Software\\Google\\Google Earth Plus\\Search';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg("GoogleEarthSearches");
		::rptMsg($key_path);
		::rptMsg("LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			my %urls;
			# Retrieve values and load into a hash for sorting			
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				my $tag = (split(/url/,$val))[1];
				$urls{$tag} = $val.":".$data;
			}
			# Print sorted content to report file			
			foreach my $u (sort {$a <=> $b} keys %urls) {
				my ($val,$data) = split(/:/,$urls{$u},2);
				::rptMsg("  ".$val." -> ".$data);
			}
		}
		else {
			::rptMsg($key_path." has no values.");
			::logMsg($key_path." has no values.");
		}
	}
	else {
		::rptMsg($key_path." not found.");
		::logMsg($key_path." not found.");
	}
}

1;
