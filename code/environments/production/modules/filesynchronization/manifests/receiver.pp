class filesynchronization::receiver (
    $ensure = $::filesynchronization::rsyncd_ensure,
    ){

    validate_re($ensure, [ '^enabled', '^disabled' ])

    include filesynchronization::receiver::service

    case $ensure {
	'enabled': {
	    include filesynchronization::receiver::setup
	    include filesynchronization::receiver::requirements
	    Class['filesynchronization::receiver::requirements']->
	    Class['filesynchronization::receiver::setup'] ~>
	    Class['filesynchronization::receiver::service']
	}
	'disabled': {
	    include filesynchronization::receiver::uninstall
	    Class['filesynchronization::receiver::uninstall'] ~>
	    Class['filesynchronization::receiver::service']
	}
    }
}