class mysql::client inherits mysql {
	package {
		[
			"mysql-client",
			"libmysql-ruby"
		]:
			ensure   => installed;
	}
}