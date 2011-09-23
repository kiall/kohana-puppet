class website::ci inherits website
{
	# Setup a Rails based site
	nginx::template::proxy {
		"ci.kohanaframework.org":
			ensure    => present,
			upstreams => [
				'127.0.0.1:8080'
			];
	}
}
