define nginx::template::proxy($upstreams, $ensure = 'present', $servers = 1, $listen = 80, $order = '100', $rails_env = 'production') {
	include nginx

	# Create the site user..
	nginx::user {
		"www-${name}":
			ensure     => present,
			groups     => "www-data";
	}

	# Create logs folder
	file {
		"/home/www-${name}/current":
			ensure   => directory,
			mode     => 2770,
			owner    => "www-${name}",
			group    => "www-${name}",
			require  => User["www-${name}"];
		"/home/www-${name}/logs":
			ensure   => directory,
			mode     => 2770,
			owner    => "www-${name}",
			group    => "www-${name}",
			require  => User["www-${name}"];
	}

	# Setup the nGinx virtual host
	nginx::site {
		$name:
			ensure	=> $ensure,
			content => template("nginx/template/proxy.conf.erb"),
			order   => $order,
			require => [
				File["/home/www-${name}/current"],
				File["/home/www-${name}/logs"]
			];
	}
}
