class szakdolgozat (
  Hash $network_interface_defaults         = $::szakdolgozat::params::network_interface_defaults,
  String $default_vhosts_directory         = $::szakdolgozat::params::default_vhosts_directory,
  String $glusterfs_host                   = $::szakdolgozat::params::glusterfs_host,
  String $glusterfs_share                  = $::szakdolgozat::params::glusterfs_share,
  String $upstream_fail_timeout            = $::szakdolgozat::params::upstream_fail_timeout,
  Integer $upstream_max_fails              = $::szakdolgozat::params::upstream_max_fails,
  String $user_default_password            = $::szakdolgozat::params::user_default_password,
  String $user_default_shell               = $::szakdolgozat::params::user_default_shell,
  String $munin_dbdir                      = $::szakdolgozat::params::munin_dbdir,
  String $munin_htmldir                    = $::szakdolgozat::params::munin_htmldir,
  String $munin_logdir                     = $::szakdolgozat::params::munin_logdir,
  String $munin_rundir                     = $::szakdolgozat::params::munin_rundir,
) inherits szakdolgozat::params {

  include ::szakdolgozat::basepackages

  validate_absolute_path([
    $default_vhosts_directory,
    $user_default_shell,
    $munin_dbdir,
    $munin_htmldir,
    $munin_logdir,
    $munin_rundir
  ])

  file {
    '/root/runpuppet.sh':
      mode    => '0755',
      tag     => 'puppet-start-at-systemup',
      content => "#!/bin/bash \n /opt/puppetlabs/bin/puppet agent --no-daemonize --onetime --verbose > /root/puppet_output.log";
    '/root/puppet_output.log':
      tag     => 'puppet-start-at-systemup';

  }

  cron {
    'PUPPET_RUN':
      ensure  => present,
      command => '/root/runpuppet.sh',
      user    => 'root',
      special => 'reboot'
  }

  class {
    '::timezone':
      timezone => 'UTC',
  }

  Class['::timezone']
  -> File <| tag == 'puppet-start-at-systemup' |> {
    ensure  => file,
    owner   => 'root',
    group   => 'root'
  }
  -> Class['::szakdolgozat::basepackages']
  -> Cron['PUPPET_RUN']


}
