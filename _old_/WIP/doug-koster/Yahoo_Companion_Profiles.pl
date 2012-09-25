#-----------------------------------------------------------
# Yahoo_Companion_Profiles.pl
#   Plugin for Registry Ripper, NTUSER.DAT edition - gets the profile names from Yahoo Companion 
#
# Change history
#   201208010Script created
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
package Yahoo_Companion_Profiles;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              osmask        => 22,
              version       => 20120810);

sub getConfig{return %config}
sub getShortDescr {
	return "Returns Yahoo Companion Profile names.";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching Yahoo_Companion_Profiles v.".$VERSION);
    ::rptMsg("Yahoo_Companion_Profiles v.".$VERSION." Author: Doug Koster TASC"); 
    ::rptMsg("(".getHive().") ".getShortDescr()."\n"); 

	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;
	
	my $key_path = 'Software\\AppDataLow\\Software\\Yahoo\\companion\\Profiles';
	my @key_names;
	my $key;
	$key = $root_key->get_subkey($key_path);
	if (@key_names = $key->get_list_of_subkeys($key_path)) {
		if (scalar(@key_names) > 0) {
			print "The registry key path is: ";
			::rptMsg($key_path."\n");
			::rptMsg("The Yahoo Companion Profile names are:"."\n");
		
			#loop through the names array and print them
			foreach my $profile (@key_names) {
				#grab just the profile name
				my $profile_name_string = $profile->as_string();
				my @profile_names = split(/\\/,$profile_name_string);
				print $profile_names[7]."\n";
			}	
		}

	}
	else {
		::rptMsg($key_path." not found.");
		::logMsg($key_path." not found.");
	}
}

1;
