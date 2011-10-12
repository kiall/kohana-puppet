# "Extensions" to built in types
class custom {
	define user($ensure = 'present', $groups = []) {
		user {
			$name:
				ensure  => $ensure,
				home    => "/home/$name",
				shell   => "/bin/bash",
				groups  => $groups;
		}

		group {
			$name:
				ensure  => $ensure,
				require => User[$name];
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
				mode    => 770,
				require => [
					User[$name],
					Group[$name]
				];
		}
	}
}
