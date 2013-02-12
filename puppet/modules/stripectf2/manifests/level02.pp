class stripectf2::level02 (
	$destination,
	$source,
) {
	service {'apache2':
		ensure => 'running',
		enable => true,
	}

	file {$destination:
		ensure => 'directory',
		recurse => true,
		purge => true,
		force => true,
		mode => '0755',
		owner => 'www-data',
		group => 'www-data',
		source => $source,
	}

	file {"$destination/uploads":
		ensure => 'directory',
		mode => '0777',
		owner => 'www-data',
		group => 'www-data',
		require => File[$destination],
	}
	
	stripectf2::random_password {"${destination}/password.txt":
		require => File[$destination],
	}
	
	file {"${destination}/password.txt":
		mode => '0333',
		owner => 'www-data',
		group => 'www-data',
		require => Stripectf2::Random_password["${destination}/password.txt"],
	}
}
