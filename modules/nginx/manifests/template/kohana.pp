define nginx::template::kohana($fpm_port, $ensure = 'present', $listen = 80, $order = '100', $kohana_env = 'production') {
	include nginx
	include php::fpm

	# Create the site user..
	nginx::user {
		"www-${name}":
			ensure     => present,
			groups     => "www-data";
	}

	# Create document root
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

	# Setup the PHP FPM pool
	php::fpm::pool {
		$name:
			ensure	=> present,
			listen  => "127.0.0.1:${fpm_port}",
			user    => "www-${name}",
			group   => "www-${name}",
			require => [
				User["www-${name}"],
				File["/home/www-${name}/current"],
				File["/home/www-${name}/logs"],
			];
	}

	# Setup the nGinx virtual host
	nginx::site {
		$name:
			ensure	=> $ensure,
			content => template("nginx/template/kohana.conf.erb"),
			order   => $order,
			require => [
				File["/home/www-${name}/current"],
				File["/home/www-${name}/logs"]
			];
	}
}
