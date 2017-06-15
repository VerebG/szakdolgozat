class filesynchronization::sender::service {
    service {
	'lsyncd':
            ensure => $::filesynchronization::lsyncd_service,
            enable => true;
    }
}