class nagios::service (
  String $provider,
  Boolean $icinga_autostart
) {

  service {
    $::nagios::service_name:
      enable   => $icinga_autostart,
      ensure   => running,
      provider => $provider;
  }
}