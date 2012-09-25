#-----------------------------------------------------------
# soft_runplus.pl
#   Get contents of the Run, RunOnce, RunServices keys from Software hive
#
# Change history
#   201206 new
#
# References
#
# Author Elizabeth Schweinsberg
# based soft_run.pl copyright 2008 H. Carvey, keydet89@yahoo.com
#-----------------------------------------------------------
package soft_runplus;
use strict;

my %config = (hive          => "Software",
              osmask        => 22,
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              version       => 20080328);

sub getConfig{return %config}

sub getShortDescr {
	return "Autostart - get Run, RunOnce, and RunServices key contents from Software hive";	
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
	::logMsg("Launching soft_runplus v.".$VERSION);
        ::rptMsg("soft_runplus v.".$VERSION); # 20110830 [fpi] + banner
        ::rptMsg("(".getHive().") ".getShortDescr()."\n"); # 20110830 [fpi] + banner

	my $reg = Parse::Win32Registry->new($hive);
	my $root_key = $reg->get_root_key;

	my $key_path = "Microsoft\\Windows\\CurrentVersion\\Run";
        fetchKey($root_key, $key_path);
        fetchKey($root_key, "Microsoft\\Windows\\CurrentVersion\\RunOnce");
        fetchKey($root_key, "Microsoft\\Windows\\CurrentVersion\\RunServices");
	
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
