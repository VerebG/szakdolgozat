class szakdolgozat::params {

  $network_interface_defaults = {
    family        => inet,
    method        => static,
    auto          => true,
    allow_hotplug => true
  }

  $default_vhosts_directory = '/vhosts'

  $glusterfs_host = 'gluster01.szakdolgozat.itautomation.cloud,gluster02.szakdolgozat.itautomation.cloud'

  $glusterfs_share = '/vhosts'

  $upstream_fail_timeout = '1s'

  $upstream_max_fails = 1

  $user_default_password = '*'

  $user_default_shell = '/usr/sbin/nologin'

  $munin_dbdir = '/var/lib/munin'

  $munin_htmldir = '/var/www/munin'

  $munin_logdir = '/var/log/munin'

  $munin_rundir = '/var/run/munin'

}