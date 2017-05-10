class szakdolgozat::munin::master (
  String $dbdir   = $::szakdolgozat::munin_dbdir,
  String $htmldir = $::szakdolgozat::munin_htmldir,
  String $logdir  = $::szakdolgozat::munin_logdir,
  String $rundir  = $::szakdolgozat::munin_rundir
){

  include ::szakdolgozat::munin::defaults

  package {
    'munin':
      ensure => latest;
  }

  class { 'apache':
    default_vhost => false,
  }

  apache::vhost {
    $fqdn:
      port    => '80',
      docroot => $htmldir,
  }

  file {
    [$dbdir, $htmldir, $logdir, $rundir]:
      ensure => directory,
      owner  => 'munin',
      group  => 'munin',
      mode   => '0755';
  }

  concat {
    '/etc/munin/munin.conf':
      owner => 'root',
      group => 'root',
      mode  => '0644',
      notify => Service['munin-node'];
  }

  concat::fragment {
    'munin_default':
      target  => '/etc/munin/munin.conf',
      content => template('szakdolgozat/munin/munin.conf.erb'),
      order   => '01';
  }

  @@concat::fragment {
    'munin_node_default':
      target  => '/etc/munin/munin-node.conf',
      content => template('szakdolgozat/munin/munin-node-part-one.conf.erb'),
      order   => '01'
  }

  Concat::Fragment <<||>>

}