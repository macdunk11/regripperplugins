#------------------------------------------------------------------------------
# ssh_host_keys.pl
#   RegRipper module to extract stored Putty and WinSCP host keys.
#   The keys are found in NTUSER.DAT under:
#       Software\Martin Prikryl\WinSCP 2\SshHostKeys
#       Software\SimonTatham\Putty\SshHostKeys
#   Presence of a host key indicates a successful connection to a given host,
#   but not necessarily a successful login.
#
# Change history
#
# References
#
# RegRipper module author Hal Pomeranz <hal.pomeranz@mandiant.com>
#------------------------------------------------------------------------------

package ssh_host_keys;

use strict;

my %config = ('hive' => 'NTUSER.DAT',
	      'hasShortDescr' => 1,
	      'hasDescr' => 0,
	      'hasRefs' => 0,
	      'osmask' => 22,
	      'version' => '20120809');

sub getConfig { return(%config); }
sub getShortDescr { return('Extracts Putty/WinSCP SSH Host Keys'); }
sub getDescr {}
sub getRefs {}
sub getHive { return($config{'hive'}); }
sub getVersion { return($config{'version'}); }

my $VERSION = $config{'version'};

sub pluginmain {
    my($class, $hive) = @_;
    my($reg, $root, $key) = ();

    ::logMsg("Launching ssh_host_keys v.$VERSION\n");

    unless ($reg = Parse::Win32Registry->new($hive)) {
	::logMsg("Failed to open $hive: $!");
	return();
    }
    unless ($root = $reg->get_root_key()) {
	::logMsg("Failed to get root key from $hive: $!");
	return();
    }

    if ($key = $root->get_subkey('Software\SimonTatham\Putty\SshHostKeys')) {
	display_key_data($key);
    }
    else {
	::logMsg('"Software\SimonTatham\Putty\SshHostKeys" does not exist' . "\n");
    }

    if ($key = $root->get_subkey('Software\Martin Prikryl\WinSCP 2\SshHostKeys')) {
	display_key_data($key);
    }
    else {
	::logMsg('"Software\Martin Prikryl\WinSCP 2\SshHostKeys" does not exist');
    }
}


sub display_key_data {
    my($key) = @_;

    my $path = $key->get_path();
    $path =~ s/.*?\\//;

    ::rptMsg("$path\nLast Updated: " . scalar(gmtime($key->get_timestamp())) . " UTC\n");

    my(%sort, %host_info) = ();
    my @vals = $key->get_list_of_values();
    foreach my $val (@vals) {
	my $name = $val->get_name();
	my($type, $port, $host) = $name =~ /^([^@]+)@(\d+):(.*)$/;
	my $host_key = $val->get_data();

	if ($host =~ /^[\d.]+$/) {
	    $sort{$name} = sprintf("%03d%03d%03d%03d", split(/\./, $host));
	}
	else { $sort{$name} = $host; }

	$host_info{$name} = {
	    'host' => $host,
	    'port' => $port,
	    'type' => $type,
	    'key' => $host_key
	};
    }

    foreach my $name (
	sort { $sort{$a} cmp $sort{$b} ||
	       $host_info{$a}{'port'} <=> $host_info{$b}{'port'} ||
	       $host_info{$a}{'type'} cmp $host_info{$b}{'type'} 
	     } keys(%host_info)) {
	::rptMsg("$host_info{$name}{'host'}:$host_info{$name}{'port'} ($host_info{$name}{'type'})");
	::rptMsg("$host_info{$name}{'key'}\n");
    }
}
    
1;
