class filesynchronization::sender (
    $ensure = $::filesynchronization::lsyncd_ensure,
    ){

    validate_re($ensure, [ '^enabled', '^disabled' ])

    include filesynchronization::sender::service

    case $ensure {
	'enabled': {
	    include filesynchronization::sender::setup
	    include filesynchronization::sender::requirements
	    Class['filesynchronization::sender::requirements']->
	    Class['filesynchronization::sender::setup'] ~>
	    Class['filesynchronization::sender::service']
	}
	'disabled': {
	}
    }
}