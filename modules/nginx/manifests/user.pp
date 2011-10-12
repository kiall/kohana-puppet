define nginx::user($ensure = 'present', $groups = []) {
	user {
		$name:
			ensure  => $ensure,
			home    => "/home/$name",
			shell   => "/bin/bash",
			groups  => $groups,
			notify  => Exec["www-data-group-${name}"];
	}

	group {
		$name:
			ensure  => $ensure,
			require => User[$name];
	}

	exec {
		"www-data-group-${name}":
			command => "usermod -a -G ${name} www-data",
			onlyif  => "test `groups www-data | grep ${name} | wc -l` -eq 0";
	}

	$home_ensure = $ensure ? {
		'present' => directory,
		default => $ensure
	}

	file {
		"/home/${name}":
			ensure  => $home_ensure,
			owner   => $name,
			group   => $name,
			mode    => 2770,
			require => [
				User[$name],
				Group[$name]
			];
	}
}