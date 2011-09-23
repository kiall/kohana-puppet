class dpkg {
	define preseed_package ($ensure, $preseed_content = false, $preseed_source = false) {

		if !$preseed_content {
			$real_preseed_source = $preseed_source ? {
				false   => "puppet:////dpkg/$name/$name.preseed",
				default => $preseed_source,
			}

			file {
				"/tmp/$name.preseed":
					source => $real_preseed_source,
					mode   => 600,
					backup => false;
			}
		} else {
			file {
				"/tmp/$name.preseed":
					content => $preseed_content,
					mode    => 600,
					backup  => false;
			}
		}

		package {
			"$name":
				ensure       => $ensure,
				responsefile => "/tmp/$name.preseed";
		}
	}
}