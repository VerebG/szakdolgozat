class backupaws::install::reprository {
    include backupaws::install::softmanager

    apt::ppa {
        'ppa:duplicity-team/ppa':
	    require => Class['backupaws::install::softmanager'];
    }
}
