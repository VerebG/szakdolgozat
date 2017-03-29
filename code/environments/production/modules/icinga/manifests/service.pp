class icinga::service (
  String $provider,
  Boolean $icinga_autostart
) {

  service {
    $::icinga::service_name:
      enable   => $icinga_autostart,
      ensure   => running,
      provider => $provider;
  }
}