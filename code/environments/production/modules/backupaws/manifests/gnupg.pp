class backupaws::gnupg (
		$gpgkey  = $::backupaws::gpg_key,
		$gpgpass = $::backupaws::gpg_pass
	) {

	file {
		"/root/.gnupg/":
			ensure => directory,
			mode   => '0700';
	}

	file {
		default: * => {
			ensure => file,
      mode   => '0600',
      owner  => 'root',
      group  => 'root'
		};
		"/root/.gnupg/gpg.conf":
			source  => "puppet:///extra_files/gpg/gpg.conf";
		"/root/.gnupg/pubring.gpg":
			source  => "puppet:///extra_files/gpg/pubring.gpg";
		"/root/.gnupg/random_seed":
			source  => "puppet:///extra_files/gpg/random_seed";
		"/root/.gnupg/secring.gpg":
			source  => "puppet:///extra_files/gpg/secring.gpg";
		"/root/.gnupg/trustdb.gpg":
			source  => "puppet:///extra_files/gpg/trustdb.gpg";
	}

}