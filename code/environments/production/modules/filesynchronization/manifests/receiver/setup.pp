class filesynchronization::receiver::setup {

    case $::filesynchronization::rsyncd_ensure {
	'enabled': {
	    $concat_ensure  = present
	}
	'disabled': {
	    $concat_ensure  = absent
	}

    }

    concat {
	$::filesynchronization::rsyncd_conf_file:
	    ensure => $concat_ensure;
    }

    concat::fragment {
	'RECEIVER_GLOBAL_SETTINGS':
	    target  => $::filesynchronization::rsyncd_conf_file,
	    content => template('filesynchronization/rsyncd/rsyncd.conf.defaults.erb'),
	    order   => '01';
    }

    augeas {
	'RSYNC_SET_DAEMON_ENABLE':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_ENABLE true',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_ENABLE != true';
	'RSYNC_SET_SHARES_LOCATION':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => "set /files/etc/default/rsync/RSYNC_CONFIG_FILE ${::filesynchronization::rsyncd_conf_file}",
	    onlyif  => "get /files/etc/default/rsync/RSYNC_CONFIG_FILE != ${::filesynchronization::rsyncd_conf_file}";
	'RSYNC_SET_LISTEN_ADDRESS':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => "set /files/etc/default/rsync/RSYNC_OPTS \"\'--address=${::filesynchronization::rsyncd_ipv4_listen} --port=873\'\" ",
	    onlyif  => "get /files/etc/default/rsync/RSYNC_OPTS != \"\'--address=${::filesynchronization::rsyncd_ipv4_listen} --port=873\'\" ";
	'RSYNC_SET_NICE':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_NICE \'10\'',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_NICE != \'10\'';
	'RSYNC_SET_IO_NICE':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_IONICE \'-c3\'',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_IONICE != \'-c3\'';
    }

}