class filesynchronization::receiver::service {
    service {
        'rsync':
            ensure => $::filesynchronization::rsyncd_service,
            enable => true;
    }
}