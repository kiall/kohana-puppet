define nginx::ssl() {
		if !defined(File["/etc/nginx/ssl"]) {
			file {
				"/etc/nginx/ssl":
					ensure => directory;
			}
		}

		if !defined(File["/etc/nginx/ssl/${name}.pem"]) {
			exec {
				"nginx-ssl-generate-${name}":
					command => "openssl req -new -inform PEM -x509 -nodes -days 999 -subj '/C=NA/ST=AutoSign/O=AutoSign/localityName=AutoSign/commonName=${name}/organizationalUnitName=AutoSign/emailAddress=AutoSign/' -newkey rsa:2048 -out /etc/nginx/ssl/${name}.pem -keyout /etc/nginx/ssl/${name}.key",
					unless	=> "test -f /etc/nginx/ssl/${name}.pem";
			}
		}
}