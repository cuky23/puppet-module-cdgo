class gocd (
  $active = undef,
  $server = undef,
  $agent = undef,
  $params = undef,
  $dl_protocol = "https",
  $dl_server = "download.gocd.io"  
) 
{
	if $params == undef {
		notify{"gocd:: wont work wihout gocd::params set one":}
	} else {
	#ubuntu version
		if $active == true {
			notify{"gocd active":}
			if $server == true {
				include gocd::server
			}
			if $agent == true {
				include gocd::agent
			}
		}
	}
}
