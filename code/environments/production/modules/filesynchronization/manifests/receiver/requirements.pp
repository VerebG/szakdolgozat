class filesynchronization::receiver::requirements {

    package {
      'rsync':
        ensure => present;
    }

    -> file {
	$::filesynchronization::rsyncd_log_dir:
	    ensure => directory;
    }

}