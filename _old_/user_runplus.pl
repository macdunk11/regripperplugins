#-----------------------------------------------------------
# user_run
#   Get contents of the Run, RunOnce, and RunServices keys from Software section of a Users Hive
#
# Change history
#   20120625 new
#
# References
#   http://msdn2.microsoft.com/en-us/library/aa376977.aspx
#   http://support.microsoft.com/kb/170086 
#
# Author: Elizabeth Schweinsberg
# Based on the user_run plugin by Harlan Carvey
#-----------------------------------------------------------
package user_runplus;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              osmask        => 22,
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              version       => 20120625);

sub getConfig{return %config}

sub getShortDescr {
	return "Autostart - get Run, RunOnce and RunServices keys contents from NTUSER\.DAT hive";	
}
sub getDescr{}
sub getRefs {
	my %refs = ("Definition of the Run keys in the WinXP Registry" =>
	            "http://support.microsoft.com/kb/314866");	
	return %refs;
}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $hive = shift;
	::logMsg("Launching user_runplus v.".$VERSION);
        ::rptMsg("user_runplus v.".$VERSION); # 20110830 [fpi] + banner
        ::rptMsg("(".getHive().") ".getShortDescr()."\n"); # 20110830 [fpi] + banner

	my $reg = Parse::Win32Registry->new($hive);
	my $root_key = $reg->get_root_key;

	my $key_path = "Software\\Microsoft\\Windows\\CurrentVersion\\Run";
	fetchKey($root_key, $key_path);
	fetchKey($root_key, "Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce");
	fetchKey($root_key, "Software\\Microsoft\\Windows\\CurrentVersion\\RunServices");
}


sub fetchKey {
        my $root_key = shift;
	my $key_path = shift;

	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg($key_path);
		::rptMsg("LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		
		my %vals = getKeyValues($key);
		if (scalar(keys %vals) > 0) {
			foreach my $v (keys %vals) {
				::rptMsg("\t".$v." -> ".$vals{$v});
			}
		}
		else {
			::rptMsg($key_path." has no values.");
		}
		
		my @sk = $key->get_list_of_subkeys();
		if (scalar(@sk) > 0) {
			foreach my $s (@sk) {
				::rptMsg("");
				::rptMsg($key_path."\\".$s->get_name());
				::rptMsg("LastWrite Time ".gmtime($s->get_timestamp())." (UTC)");
				my %vals = getKeyValues($s);
				foreach my $v (keys %vals) {
					::rptMsg("\t".$v." -> ".$vals{$v});
				}
			}
		}
		else {
			::rptMsg("");
			::rptMsg($key_path." has no subkeys.");
		}
	}
	else {
		::rptMsg($key_path." not found.");
		::logMsg($key_path." not found.");
	}
}

sub getKeyValues {
	my $key = shift;
	my %vals;
	
	my @vk = $key->get_list_of_values();
	if (scalar(@vk) > 0) {
		foreach my $v (@vk) {
			next if ($v->get_name() eq "" && $v->get_data() eq "");
			$vals{$v->get_name()} = $v->get_data();
		}
	}
	else {
	
	}
	return %vals;
}

1;
