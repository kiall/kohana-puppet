class php::pear::php_codesniffer {
	package {
		"PHP_CodeSniffer":
			provider => "pear",
			source   => "pear",
			ensure   => "1.2.2";
	}
}
