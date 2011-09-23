class php::fpm inherits php {

	package {
		"php5-fpm":
			ensure => installed
	}

	service {
		"php5-fpm":
			ensure    => running,
			hasstatus => false,
			status    => 'true',
			enable    => true,
			require   => File["/etc/php5/fpm/main.conf"],
	}

	file {
		"/etc/php5/fpm/main.conf":
			ensure   => present,
			owner	 => root,
			group	 => root,
			mode	 => 644,
			content  => template("php/main.conf.erb"),
			require  => Package["php5-fpm"];
		"/etc/php5/fpm/pool.d":
			ensure   => directory,
			owner	 => root,
			group	 => root,
			mode	 => 644,
			require  => Package["php5-fpm"];
	}

	exec {
		"reload-php5-fpm":
			command     => "/etc/init.d/php5-fpm reload",
			refreshonly => true;
	}

	# Remove the default www pool .. Kinda nasty :/
	file {
		"/etc/php5/fpm/pool.d/www.conf":
			ensure   => absent,
			notify   => Exec["reload-php5-fpm"];
	}

	# Defines a new FPM pool
	define pool($ensure = 'present', $user = 'www-data', $group = 'www-data',
	            $order='100', $listen = '127.0.0.1:9000', $listen_backlog = '-1',
	            $listen_owner = 'www-data', $listen_group = 'www-data',
	            $listen_mode = '0666', $listen_allowed_clients = false,
	            $pm = 'dynamic', $pm_max_children = 50, $pm_start_servers = false,
	            $pm_min_spare_servers = 5, $pm_max_spare_servers = 35, $pm_max_requests = 0) {

		file {
			"/etc/php5/fpm/pool.d/${order}-${name}.conf":
				ensure   => $ensure,
				content  => template("php/pool.conf.erb"),
				mode     => 644,
				owner    => root,
				group    => root,
				notify   => Exec["reload-php5-fpm"],
				before   => Service["php5-fpm"];
		}
	}
}