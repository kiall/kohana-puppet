# Setup user accounts
custom::user {
	"kiall":
		ensure => present,
		groups => [
			"developers",
			"admin",
			"www-kohanaframework.org",
			"www-www.kohanaframework.org",
			"www-dev.kohanaframework.org",
			"www-forum.kohanaframework.org",
			"www-ci.kohanaframework.org",
			"www-pear.kohanaframework.org"
		];
	"zombor":
		ensure => present,
		groups => [
			"developers",
			"admin",
			"www-kohanaframework.org",
			"www-www.kohanaframework.org",
			"www-dev.kohanaframework.org",
			"www-forum.kohanaframework.org",
			"www-ci.kohanaframework.org",
			"www-pear.kohanaframework.org"
		];
	"samsoir":
		ensure => present,
		groups => [
			"developers",
			"admin",
			"www-kohanaframework.org",
			"www-www.kohanaframework.org",
			"www-dev.kohanaframework.org",
			"www-forum.kohanaframework.org",
			"www-ci.kohanaframework.org",
			"www-pear.kohanaframework.org"
		];
	"isaiah":
		ensure => present,
		groups => [
			"developers",
			"admin",
			"www-kohanaframework.org",
			"www-www.kohanaframework.org",
			"www-dev.kohanaframework.org",
			"www-forum.kohanaframework.org",
			"www-ci.kohanaframework.org",
			"www-pear.kohanaframework.org"
		];
	"brmatt":
		ensure => present,
		groups => [
			"developers",
			"www-kohanaframework.org",
			"www-www.kohanaframework.org",
			"www-dev.kohanaframework.org",
			"www-forum.kohanaframework.org",
			"www-ci.kohanaframework.org",
			"www-pear.kohanaframework.org"
		];
}

# Setup SSH Keys
ssh_authorized_key {
	"kiall@wk01-lmst.managedit.ie":
		ensure  => present,
		user    => "kiall",
		type    => "ssh-rsa",
		key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAl5eTgQ1IMCr9pFPiR1ZdpnNaORqmfCgqhSsUOv5E6w6anzc/K4Xj9wy5gxvrrG7hVqI7iNQ+Yddfcc4QXfMkUO9CPWUBC2bXs21Sy5nPnGyveJIro+LbBkf+FPyN/WL95O8ymJ/7V0Suo+XSTO25wu4LLe2t33QNtZpPYthD0amHGuVhbL97ie7dwA9iZQfGsGIgrd10+uGYNKlb+NwEF9i+w6t4tGjyjuE4cxo2E+/KmiwNShOXQ7eq4a0qf7kmz6ZIZEBo8Gut0OcmzL8bb4PxVbQsL1IqwkbNa4oN+w7+TLVbdmGxqYO0tgVz2FadgXEnX3jlzPWYyDTk2bbI/w==",
		options => [],
		require => User["kiall"];
	"kiall@kiall-laptop":
		ensure  => present,
		user    => "kiall",
		type    => "ssh-rsa",
		key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCswAbmT3k9NojL9xQKWrW4yiveJLFqNBFmRvrXLjLb2CvwAMnMdNMQmuJe2olTopiWlEkryZl2o8hiDbGdYrMNU278tVKoU+XTkKxHd9+00cFT2rZCaL0umkWxkSUIGwEcl8dVDxQKuRK3FQ7+0t58wLmMqPU6qcZSA1ruOJ3XvBFZWQZk/keT4vCzZBY39QetX+ge5YhXSpYdwZ78T4x8QcEkuccuNxj7fOVXlaH6w9E8hP13VgjIWz3zrWM8ZmgiVE9ro1RokyFYPW4eb3jd6WRvDOjm7lEsD7mdKZB6ZXZ6IHtgAui0WtIcQqZCEYhz7yaaQ8mnHTd9N07yq8nf",
		options => [],
		require => User["kiall"];
	"matthew@sigswitch.com":
		ensure  => present,
		user    => "brmatt",
		type    => "ssh-rsa",
		key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAvR3hLb7gdXHGLWEu3Rt9hBpfidN7MXO/HOnX8BBoaz9RfrEr68SlKlKLpZ8MInUrOeCTq2E5NQpgcN7hPRh/aFM2oHpYPBx6z0EroaMROWJtujDEi5U1lWFKhywROMA5VTgkcizA11mjTABonccLiirzjPh0DgCU4bUMoKJpGfzNU/OJweyqDvEgyLib2NDL1ntrShzx5gkgc/24QliBhiu15ZBYXnrU1VrMF7SY13tB7TdEOC+/qpHU7Zz8TNLjzLoFKo/LSZWA6ZWagZj0YmLXj6R2CX1jvvaJiorQ1Z/neJ8EU1Qy+9qLKfYCa+QiJP9/RUaMhG0dFtRFkiT6YQ==",
		options => [],
		require => User["brmatt"];
	"contractfrombelow@gmail.com":
		ensure  => present,
		user    => "zombor",
		type    => "ssh-rsa",
		key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEA0QY0KaYcYQ7F2FJgvGbJm1rSP1HQo5XYxrl+rI6DqAFWjnNp7kq/9zeSJ4GdUYPNXDpoDUnyg7Z/mD2wB36/0vF2yf9GTqcMaWRuf8rEPd6GTLGjFStLKn0kniZFDZpeIYl89c2GSmZUnWqY8UfQEyHGzVweB11RglTQJuIvi1uhNbLsSNsDfb9hzYWaNGf77SVPCbOVLTN76xd0EZmonPxyDSIS+SHEGkNHEMpuqQEV/Es5fZ/d+jGmMbOwToeszpfs7FiWVFDBn+WHLpiYHixFrhf/dHWaf2Rvf/wmobgXxIph8gI3VzzN934BTDe9a24jxaezwQO3BqQGIlR5tw==",
		options => [],
		require => User["zombor"];
	"sam@def.reyssi.net":
		ensure  => present,
		user    => "samsoir",
		type    => "ssh-rsa",
		key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAwpzZ9IwKtKZXkVasS+FBod2Qo+mxLPSyQ4qZrEzE+LQiBoMMol9guJHgOLbMmH0ekL4tMm3e67oZaIaW/XoLeBPi86VnTXxw8UekJaQbpZNrCOxDuolvBqvsxJpYguw7TIJOnEKrdOfPPCgdAvfn3C24Ck+PL6LZ3TGAvreKqY7khhuEo5lKQayRhBnO3whmzh9ijnhYNuLV/c3uxQaWygm02jqqrhzM/BtNtpV/CjcGJdFIt96UFXdQPCS2rx+KEA0nR1uL0YuG1RDK2GoKmN8WG/jrdlQ08fcXZtoCHePI8eUG2hlMYO1pjLoiL/ZLB3mwkahGlZxK58bUmdNf2w==",
		options => [],
		require => User["samsoir"];
}