class szakdolgozat::network (
  Hash $networks,
  Hash $network_interface_defaults = $::szakdolgozat::network_interface_defaults
){

  #Disable auto interface restart
  class {
    network:
      config_file_notify => '';
  }

  $networks.each |String $interface, Hash $parameters| {
    Resource[network::interface] {
      $interface: * => $parameters;
      default:    * => $network_interface_defaults;
    }
  }

}