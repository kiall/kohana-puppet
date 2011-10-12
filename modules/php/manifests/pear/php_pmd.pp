class php::pear::php_pmd {
	package {
		"PHP_PMD":
			provider => "pear",
			source   => "phpmd",
			ensure   => "1.1.1";
	}
}
