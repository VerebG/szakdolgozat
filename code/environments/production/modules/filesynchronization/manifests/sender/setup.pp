class filesynchronization::sender::setup {

    case $::filesynchronization::lsyncd_ensure {
	'enabled': {
	    $concat_ensure  = present
	}
	'disabled': {
	    $concat_ensure  = absent
	}

    }

    concat {
	$::filesynchronization::lsyncd_conf_file:
	    ensure => $concat_ensure;
    }

    concat::fragment {
	'SENDER_GLOBAL_SETTINGS':
	    target  => $::filesynchronization::lsyncd_conf_file,
	    content => template('filesynchronization/lsyncd/lsyncd.conf.lua.globals.erb'),
	    order   => '01';
    }


}