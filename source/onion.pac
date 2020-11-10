
#/etc/tor/
function FindProxyForURL(url, host)
{
	if (shExpMatch(host,"*.onion"))
	{
		return "SOCKS 127.0.0.1:9050";
	}
	
} 
