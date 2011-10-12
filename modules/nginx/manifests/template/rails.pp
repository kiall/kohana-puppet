define nginx::template::rails($thin_port, $ensure = 'present', $servers = 1, $listen = 80, $order = '100', $rails_env = 'production') {
	include nginx
	include ruby::thin

	# Create the site user..
	nginx::user {
		"www-${name}":
			ensure     => present,
			groups     => "www-data";
	}

	# Create document root and logs folders
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
		"/home/www-${name}/tmp":
			ensure   => directory,
			mode     => 2770,
			owner    => "www-${name}",
			group    => "www-${name}",
			require  => User["www-${name}"];
		"/home/www-${name}/tmp/pids":
			ensure   => directory,
			mode     => 2770,
			owner    => "www-${name}",
			group    => "www-${name}",
			require => [
				User["www-${name}"],
				File["/home/www-${name}/tmp"],
			];
	}

	# Setup the thin server
	ruby::thin::server {
		$name:
			ensure	=> present,
			port    => $thin_port,
			servers => $servers,
			chdir   => "/home/www-${name}/current",
			user    => "www-${name}",
			group   => "www-${name}",
			require => [
				User["www-${name}"],
				File["/home/www-${name}/current"],
				File["/home/www-${name}/logs"],
				File["/home/www-${name}/tmp"],
				File["/home/www-${name}/tmp/pids"],
			];
	}

	# Setup the nGinx virtual host
	nginx::site {
		$name:
			ensure	=> $ensure,
			content => template("nginx/template/rails.conf.erb"),
			order   => $order,
			require => [
				File["/home/www-${name}/current"],
				File["/home/www-${name}/logs"]
			];
	}
}
