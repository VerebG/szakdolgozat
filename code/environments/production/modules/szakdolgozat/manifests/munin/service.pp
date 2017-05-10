class szakdolgozat::munin::service {

  service {
    'munin-node':
      ensure   => running,
      enable   => true,
      provider => systemd;
  }

}