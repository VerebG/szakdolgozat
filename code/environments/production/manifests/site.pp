
Package {
  provider => apt
}

Exec {
  path => '/opt/puppetlabs/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
}

class {
  '::timezone':
    timezone => 'UTC',
}

node 'sync01' {

  include ::stdlib
  include ::apt


  class {
    network:
      config_file_notify => '';
  }

  $network = lookup('network', Hash, 'deep')

  $network.each |String $interface, Hash $parameters| {
    Resource[network::interface] {
      $interface: * => $parameters;
      default:    * => {
        family        => inet,
        method        => static,
        auto          => true,
        allow_hotplug => true
      };
    }
  }

  $filesynchronization = lookup('filesynchronization', Hash, 'deep')


  class {
    'filesynchronization':
      mode               => $filesynchronization['mode'],
      lsyncd_targets     => $filesynchronization['sender']['targets'];
    'filesynchronization::sender':
      ;
  }


}

node 'sync02' {

  $filesynchronization = lookup('filesynchronization', Hash, 'deep')

  class {
    'filesynchronization':
      mode               => $filesynchronization['mode'],
      rsyncd_ipv4_listen => $filesynchronization['receiver']['listen'],
      rsyncd_shares      => $filesynchronization['receiver']['targets'];
    'filesynchronization::receiver':
      ;
  }

}