define nginx::site($content, $ensure = 'present', $order = '100') {
	file {
		"/etc/nginx/sites-puppet/${order}-${name}.conf":
			ensure   => $ensure,
			content  => $content,
			mode     => 644,
			owner    => root,
			group    => root,
			notify   => Exec["reload-nginx"],
			before   => Service["nginx"];
	}

	# Export default nagios services
	@@nagios_service {
		"check_http_${name}":
			check_command       => "check_http2!${name}!1!5",
			use                 => "generic-service",
			host_name           => "$fqdn",
			notification_period => "24x7",
			service_description => "check_http_${name}";
	}
}
