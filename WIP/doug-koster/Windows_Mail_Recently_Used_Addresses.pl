#-----------------------------------------------------------
# Windows_Mail_Recently_Used_Addresses.pl
#   Plugin for Registry Ripper, NTUSER.DAT edition - gets last 29 email addresses that the user sent emails to  using Windows Vista Mail Client
#
# Change history
#   20120810 Script created
# 
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
package Windows_Mail_Recently_Used_Addresses;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              osmask        => 22,
              version       => 20120810);

sub getConfig{return %config}
sub getShortDescr {
	return "Returns last email addresses user sent emails to via WindowsMail (up to 29).";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching Windows_Mail_Recently_Used_Addresses v.".$VERSION);
    	::rptMsg("Windows_Mail_Recently_Used_Addresses v.".$VERSION." Author: Doug Koster TASC"); 
    	::rptMsg("(".getHive().") ".getShortDescr()."\n"); 

	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;
	
	my $key_path = 'Software\\Microsoft\\Windows Mail\\Recently Used Addresses';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg("Windows_Mail_Recently_Used_Addresses");
		::rptMsg($key_path);
		::rptMsg("LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			my %emails;
			# Retrieve values and load into a hash for sorting			
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				my $tag = (split(/url/,$data))[0];
				$tag = s/\x00//g;
				$emails{$v->get_names()} = $tag
			}
			# Print sorted content to report file			
			foreach my $r (sort keys %emails) {
				::rptMsg($r."   ".$emails{$r});
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
