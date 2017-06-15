class filesynchronization::sender::requirements {

    package {
	'lsyncd':
	    ensure => installed;
    }

    -> file {
	[
	    $::filesynchronization::lsyncd_conf_dir,
	    $::filesynchronization::lsyncd_log_dir
	]:
	    ensure => directory;
    }

}