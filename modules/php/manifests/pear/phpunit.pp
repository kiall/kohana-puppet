class php::pear::phpunit {
	package {
		"PHPUnit":
			provider => "pear",
			source   => "phpunit",
			ensure   => "3.5.5";
	}
}
