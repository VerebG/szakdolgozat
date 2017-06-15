define filesynchronization::receiver::target (
    $path        = undef,
    $logfile     = "${::filesynchronization::rsyncd_log_dir}/${name}.log",
    $comment     = undef,
    $readonly    = $::filesynchronization::rsyncd_share_read_only,
    $writeonly   = $::filesynchronization::rsyncd_share_write_only,
    $uid         = $::filesynchronization::rsyncd_uid,
    $gid         = $::filesynchronization::rsyncd_gid,
    $incomechmod = $::filesynchronization::rsyncd_incoming_chmod,
    $outgochmod  = $::filesynchronization::rsyncd_outgoing_chmod,
    $hostsallow  = undef 
    ){

    validate_absolute_path($path, $logfile)
    validate_string($comment)
    validate_re($readonly, [ '^yes', '^no' ])
    validate_re($writeonly, [ '^yes', '^no' ])
    validate_string($uid)
    validate_string($gid)
    validate_integer($incomechmod)
    validate_integer($outgochmod)

    $ip_addresses = split($hostsallow, ', ')

    if count($ip_addresses) > 1{
      filesynchronization::receiver::ip_validator {
	      $ip_addresses:
		      ;
	    }
    } else {
	    validate_ip_address($hostsallow)
    }

    concat::fragment {
	"RECEIVER_${name}":
	    target  => $::filesynchronization::rsyncd_conf_file,
	    content => template('filesynchronization/rsyncd/rsyncd.conf.share.erb');
    }

}