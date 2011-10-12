class php::pear::php_codesniffer_standards_kohana {
	package {
		"PHP_CodeSniffer_Standards_Kohana":
			provider => "pear",
			source   => "kohana",
			ensure   => latest;
	}
}
