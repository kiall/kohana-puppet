class jenkins {
	$key_url     = "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
	$key_id      = "D50582E6"
    $repo_url    = "deb http://pkg.jenkins-ci.org/debian binary/"
    $apt_sources = "/etc/apt/sources.list.d/jenkins.list"

	exec {
		"install-jenkins-key":
			command  => "wget -q -O - ${key_url} | apt-key add -",
			onlyif   => "test `apt-key list | grep ${key_id} | wc -l` -eq 0";
		"install-jenkins-repo":
			command  => "echo '${repo_url}' >> ${apt_sources}",
			unless   => "test -f ${apt_sources}"
			require  => Exec["install-jenkins-key"];
		"update-jenkins-repo":
			command  => "apt-get update",
			unless   => "dpkg -S jenkins",
			require  => Exec["install-jenkins-repo"];
    }

	package {
		"jenkins":
			ensure  => latest,
			require => Exec["update-jenkins-repo"];
	}

	service {
		"jenkins":
			ensure  => running,
			require => Package["jenkins"];
	}
}