class filesynchronization::receiver::uninstall {

    augeas {
	'RSYNC_SET_DAEMON_DISABLE':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_ENABLE false',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_ENABLE != false';
	'RSYNC_SET_SHARES_LOCATION_EMPTY':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_CONFIG_FILE "\'\'"',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_CONFIG_FILE != "\'\'"';
	'RSYNC_SET_LISTEN_ADDRESS_EMPTY':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_OPTS "\'\'"',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_OPTS != "\'\'"';
	'RSYNC_SET_NICE_EMPTY':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_NICE "\'\'"',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_NICE != "\'\'"';
	'RSYNC_SET_IO_NICE_EMPTY':
	    context => $::filesynchronization::rsyncd_daemon_conf_file,
	    changes => 'set /files/etc/default/rsync/RSYNC_IONICE "\'\'"',
	    onlyif  => 'get /files/etc/default/rsync/RSYNC_IONICE != "\'\'"';
    }

}