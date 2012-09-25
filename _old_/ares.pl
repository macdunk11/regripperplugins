#-----------------------------------------------------------
# ares.pl
# 
#
# Change history
#   20120507 - modified to remove the traversing function, to only get
#              a limited amount of data.
#   20110603 - modified F. Kolenbrander
#	       parsing some values according ares source code, like searches and 
#        timestamps.
#   20110530 - created
#   
# References
#
# 
# copyright 2012 Quantum Analytics Research, LLC
# author: H. Carvey, keydet89@yahoo.com
#-----------------------------------------------------------
package ares;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 0,
              osmask        => 22,
              version       => 20110530);

sub getConfig{return %config}
sub getShortDescr {
	return "Gets contents of user's Software/Ares key";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}


my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching ares v.".$VERSION);
	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;

	my $key_path = 'Software\\Ares';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg($key_path);
		::rptMsg("LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
#		::rptMsg("");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				::rptMsg("Stats\.LstConnect            -> ".gmtime($v->get_data())) if ($v->get_name() eq "Stats\.LstConnect");
				::rptMsg("Personal\.Nickname           -> ".hex2ascii($v->get_data())) if ($v->get_name() eq "Personal\.Nickname");
				::rptMsg("General\.Language            -> ".hex2ascii($v->get_data())) if ($v->get_name() eq "General\.Language");
				::rptMsg("PrivateMessage\.AwayMessage  -> ".hex2ascii($v->get_data())) if ($v->get_name() eq "PrivateMessage\.AwayMessage");
			}
		}
		else {
			::rptMsg($key->get_name()." has no values.");
		}
		::rptMsg("");
		getSearchTerms($key);
		
	}
	else {
		::rptMsg($key_path." not found.");
	}
}

sub getSearchTerms {
	my $key = shift;
	my $gen = $key->get_subkey("Search\.History")->get_subkey("gen\.gen");
	my @vals = $gen->get_list_of_values();
	if (scalar(@vals) > 0) {
		::rptMsg("Search Terms:");
		::rptMsg($gen->get_name()." LastWrite: ".gmtime($gen->get_timestamp()));
		foreach my $v (@vals) {
			next if ($v->get_name() eq "");
			::rptMsg(" - ".hex2ascii($v->get_name()));
		}
	}
	else {
		::rptMsg("No Search Terms found.");
	}
	
}

sub hex2ascii {
  return pack('H*',shift); 
}

1;