class nagios::service (
  String $provider,
  Boolean $icinga_autostart
) {

  service {
    $::nagios::package_name:
      enable   => $icinga_autostart,
      ensure   => running,
      provider => $provider;
  }
}