#-----------------------------------------------------------
# typedurlstime_tln.pl
#   Plugin for Registry Ripper, NTUSER.DAT edition - gets the TypedURLs and TypedURLsTime values and outputs to TLN format
#
# Change history
#   20120612 [Based on TypedURLs.pl and UserAssist2.pl]
#
# References
#
# Author: Jason Hale <ntexaminer@gmail.com>
#-----------------------------------------------------------
package typedurlstime_tln;
use strict;

my %config = (hive          => "NTUSER\.DAT",
              hasShortDescr => 1,
              hasDescr      => 0,
              hasRefs       => 1,
              osmask        => 22,
              version       => 20120612);

sub getConfig{return %config}
sub getShortDescr {
	return "Correlates & returns contents of user's TypedURLs and TypedURLsTime key.";	
}
sub getDescr{}
sub getRefs {}
sub getHive {return $config{hive};}
sub getVersion {return $config{version};}

my $VERSION = getVersion();
		

sub pluginmain {
	my $class = shift;
	my $ntuser = shift;
	::logMsg("Launching typedurlstime v.".$VERSION);
    ::rptMsg("typedurlstime v.".$VERSION); 
    ::rptMsg("(".getHive().") ".getShortDescr()."\n"); 

	my $reg = Parse::Win32Registry->new($ntuser);
	my $root_key = $reg->get_root_key;
	
	my $ie_key = 'Software\\Microsoft\\Internet Explorer\\';
	my $key_path = $ie_key."\TypedURLS";
	my %urls;
	my %times;
	my $url_lastwrite;
	my $time_lastwrite;
	
	if (my $key = $root_key->get_subkey($key_path)) 
	{
		$url_lastwrite = gmtime($key->get_timestamp());
		
		#Retrieve contents of TypedURLs key
		
		my @urlvals = $key->get_list_of_values();
		if (scalar(@urlvals) > 0) 
		{
			
		# Retrieve values and load into a hash for sorting			
			foreach my $v (@urlvals) 
			{
				my $val = $v->get_name();
				my $data = $v->get_data();
				my $tag = (split(/url/,$val))[1];
				$urls{$tag} = $val.":".$data;
			}
		}
		
		}
		else {
			::rptMsg($key_path." has no values.");
			::logMsg($key_path." has no values.");
		}
	
	my $key_path = $ie_key."\TypedURLSTime";
	
	if (my $key = $root_key->get_subkey($key_path)) 
	{
		$time_lastwrite = gmtime($key->get_timestamp());
							
		#Retreive contents of TypedURLsTime key
		my @timevals = $key->get_list_of_values();
		if (scalar(@timevals) > 0) 
		{
			# Retrieve values and load into a hash for sorting			
			foreach my $v (@timevals) 
			{
				my $val = $v->get_name();
				my $data = $v->get_data();
				if (length($data) == 8)
				{
					my ($val1,$val2) = unpack("V*",$data);
					if ($val2 != 0) 
					{
						my $time_value = ::getTime($val1,$val2);
						$data = $time_value;					
					}
				}
				my $tag = (split(/url/,$val))[1];
				$times{$tag} = $val.":".$data;
			}
			
			#Correlate values from TypedURLs and TypedURLsTime
			for(my $i = 0; $i <= 50; $i++)
			{
				my($val1,$data1) = split(/:/,$urls{$i},2);
				my($val2,$data2) = split(/:/,$times{$i},2);
				if(($val1 eq $val2) && ($val1 ne undef) && ($val2 ne undef))
				{
					::rptMsg($data2."|NTUSER.DAT|TypedURLs/TypedURLsTime Entry|0|".$data1);
				}			
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