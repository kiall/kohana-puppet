import "site.pp"
import "ssl.pp"

class nginx {

	package {
		"nginx":
			name   => "nginx-full",
			ensure => installed
	}

	service {
		"nginx":
			ensure    => running,
			enable    => true,
			require   => File["/etc/nginx/nginx.conf"],
	}

	file {
		"/etc/nginx/nginx.conf":
			ensure   => present,
			owner	 => root,
			group	 => root,
			mode	 => 644,
			content  => template("nginx/nginx.conf.erb"),
			require  => Package["nginx"];
		"/etc/nginx/sites-puppet":
			ensure   => directory,
			mode     => 644,
			owner    => root,
			group    => root;
	}

	exec {
		"reload-nginx":
			command     => "/etc/init.d/nginx reload",
			refreshonly => true;
	}
}


