#-----------------------------------------------------------
# pstools.pl
#   Plugin for Registry Ripper
#
# Change history
#
# References
#   Harlan Carvey http://windowsir.blogspot.com
# 
# copyright 2012 John Lukach
#-----------------------------------------------------------
package pstools;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 0,
              hasDescr      => 0,
              hasRefs       => 0,
              osmask        => 22,
              version       => 20120704);

sub getConfig{return %config}
sub getShortDescr {
	return "Displays the content for PsTools EULA Agreements";
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching pstools v.".$VERSION);
	::rptMsg("pstools v.".$VERSION);
	::rptMsg("(".getHive().") ".getShortDescr()."\n");

	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;

	::rptMsg("PsTools");

	my $key_path = 'Software\\SysInternals\\PsExec';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsFile';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsGetSID';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsInfo';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsKill';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsList';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsLoggedOn';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsLogList';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsPasswd';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsService';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsShutDown';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

	my $key_path = 'Software\\SysInternals\\PsSuspend';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg(($key_path)."  LastWrite Time ".gmtime($key->get_timestamp())." (UTC)");
		my @vals = $key->get_list_of_values();
		if (scalar(@vals) > 0) {
			foreach my $v (@vals) {
				my $val = $v->get_name();
				my $data = $v->get_data();
				::rptMsg("  ".$val." -> ".$data);
			}
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}

}

1;
