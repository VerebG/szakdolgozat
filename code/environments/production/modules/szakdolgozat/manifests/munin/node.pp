class szakdolgozat::munin::node (

){

  include ::szakdolgozat::munin::defaults

  package {
    'libregexp-common-net-cidr-perl':
      ensure => latest;
  }

  concat {
    '/etc/munin/munin-node.conf':
      owner => 'root',
      group => 'root',
      mode  => '0644',
      notify => Service['munin-node'];
  }

  concat::fragment {
    'munin_node_listen':
      target  => '/etc/munin/munin-node.conf',
      content => template('szakdolgozat/munin/munin-node-part-two.conf.erb'),
      order   => '02'
  }

  @@concat::fragment {
    "munin_node_${fqdn}":
      target  => '/etc/munin/munin.conf',
      content => template('szakdolgozat/munin/munin-node.conf.erb'),
  }

  Concat::Fragment <<||>>

}