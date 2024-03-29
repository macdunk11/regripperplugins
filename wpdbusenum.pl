#-----------------------------------------------------------
# wpdbusenum
# Gets contents of Enum\WpdBusEnumRoot keys
# 
#
# History:
#  20120523 - Added support for a DeviceClasses subkey that includes 
#             "WpdBusEnum" in the names; from MarkW and ColinC
#  20120410 - created
#
# copyright 2012 Quantum Analytics Research, LLC
# Author: H. Carvey, keydet89@yahoo.com
#-----------------------------------------------------------
package wpdbusenum;
use strict;

my %config = (hive          => "System",
              osmask        => 22,
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 0,
              version       => 20120523);

sub getConfig{return %config}

sub getShortDescr {
	return "Get WpdBusEnumRoot subkey info";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();
my $reg;

sub pluginmain {
	my $class = shift;
	my $hive = shift;
	$reg = Parse::Win32Registry->new($hive);
	my $root_key = $reg->get_root_key;

# Code for System file, getting CurrentControlSet
	my $current;
	my $ccs;
	my $key_path = 'Select';
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		$current = $key->get_value("Current")->get_data();
		$ccs = "ControlSet00".$current;
	}
	else {
		::rptMsg($key_path." not found.");
		return;
	}
	
	my $key_path = $ccs."\\Enum\\WpdBusEnumRoot";
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {

		my @subkeys = $key->get_list_of_subkeys();
		if (scalar(@subkeys) > 0) {
			foreach my $s (@subkeys) {
				my $dev_class = $s->get_name();
				my @sk = $s->get_list_of_subkeys();
				if (scalar(@sk) > 0) {
					foreach my $k (@sk) {
						my $serial = $k->get_name();
						my ($dev,$sn) = (split(/#/,$k->get_name(),5))[3,4];
						$sn =~ s/#$//;
						::rptMsg($dev." (".$sn.")");
						
						my $sn_lw = $k->get_timestamp();
						::rptMsg("  LastWrite: ".gmtime($sn_lw));
						
						eval {
							::rptMsg("DeviceDesc: ".$k->get_value("DeviceDesc")->get_data());
						};
						
						eval {
							::rptMsg("Friendly: ".$k->get_value("FriendlyName")->get_data());
						};
						
						eval {
							::rptMsg("Mfg: ".$k->get_value("Mfg")->get_data());
						};
						::rptMsg("");
					}
				}
			}
		}
		else {
			::rptMsg($key_path." has no subkeys.");
		}
	}
	else {
		::rptMsg($key_path." not found.");
	}
	
# Added on 20120523, based on a tweet from Mark Woan while he was attending
# CEIC2012; he attributes this to ColinC.  Googling for this key, I found a
# number of references to USBOblivion, a tool described as being able to wipe
# out (all) indications of USB removable storage devices being connected to
# the system.
	my $key_path = $ccs."\\Control\\DeviceClasses\\{10497b1b-ba51-44e5-8318-a65c837b6661}";
	my $key;
	if ($key = $root_key->get_subkey($key_path)) {
		::rptMsg($key_path);
		my @subkeys = $key->get_list_of_subkeys();
		if (scalar(@subkeys) > 0) {
			foreach my $s (@subkeys) {
				my $name = $s->get_name();
				my $lw   = $s->get_timestamp();
				
				my (@n) = split(/#/,$name);
				
				if ($n[3] eq "WpdBusEnumRoot") { 
					::rptMsg($n[8]."\\".$n[9]);
					::rptMsg("LastWrite: ".gmtime($lw));
					::rptMsg("");
				}
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
1;