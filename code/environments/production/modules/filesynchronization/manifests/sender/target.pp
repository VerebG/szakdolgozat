define filesynchronization::sender::target (
    $source     = undef,
    $target     = undef,
    $username   = undef,
    $share      = undef,
    $autodelete = false
    ){

    validate_absolute_path($source)
    validate_string($target)
    validate_string($username)
    validate_string($share)
    validate_bool($autodelete)

    concat::fragment {
	"SENDER_${name}":
	    target  => $::filesynchronization::lsyncd_conf_file,
	    content => template('filesynchronization/lsyncd/lsyncd.conf.lua.target.erb');
    }

}