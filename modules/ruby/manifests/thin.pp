class ruby::thin inherits ruby {

	package {
		"thin":
			ensure   => installed,
			provider => "gem";
	}

	file {
		"/etc/thin":
			ensure   => directory,
			mode     => 644,
			owner    => root,
			group    => root;
	}

	service {
		"thin":
			provider  => base,
			start     => "/var/lib/gems/1.8/bin/thin --all /etc/thin restart",
			restart   => "/var/lib/gems/1.8/bin/thin --all /etc/thin restart",
			stop      => "/var/lib/gems/1.8/bin/thin --all /etc/thin stop";
	}

	# Defines a new thin server pool
	define server($chdir, $ensure = 'present', $user = 'www-data', $group = 'www-data',
	              $port = 3000, $address = '127.0.0.1', $servers = 1) {

		file {
			"/etc/thin/${name}.yml":
				ensure   => $ensure,
				content  => template("ruby/thin.yml.erb"),
				mode     => 644,
				owner    => root,
				group    => root,
				notify   => Service["thin-${name}"];
		}

		service {
			"thin-${name}":
				ensure    => running,
				provider  => base,
				start     => "/var/lib/gems/1.8/bin/thin -C /etc/thin/${name}.yml restart",
				restart   => "/var/lib/gems/1.8/bin/thin -C /etc/thin/${name}.yml restart",
				stop      => "/var/lib/gems/1.8/bin/thin -C /etc/thin/${name}.yml stop",
				status    => "cd ${chdir}/../tmp/pids && thin_status(){ for filename in *.pid; do kill -0 `cat \$filename` || return 1; done; }; thin_status";
		}
	}
}