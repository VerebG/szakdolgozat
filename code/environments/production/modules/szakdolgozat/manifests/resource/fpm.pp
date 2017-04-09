define szakdolgozat::resource::fpm (
  Enum['present', 'absent'] $ensure,
  Pattern[/^([0-9]{1,3}\.){3}[0-9]{1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))?$/] $listen_ip,
  Integer $listen_port,
  Pattern[/^([0-9]{1,3}\.){3}[0-9]{1,3}(\/([0-9]|[1-2][0-9]|3[0-2]))?$/] $allowed_clients,
  Hash $environments,
  Hash $php_flag,
  Hash $php_value
) {

  $vhost_directory = "${::szakdolgozat::default_vhosts_directory}/${name}"

  file {
    [
      $vhost_directory,
      "${vhost_directory}/logs",
      "${vhost_directory}/www"
    ]:
      ensure => directory,
      owner  => $name,
      group  => $name,
      mode   => '0755',
      tag    => 'required-folders';
  }

  phpfpm::pool {
    $name:
      ensure                 => $ensure,
      user                   => $name,
      group                  => $name,
      listen                 => "${listen_ip}:${listen_port}",
      listen_allowed_clients => $allowed_clients,
      chroot                 => "/",
      access_log             => "${vhost_directory}/logs/access.log",
      pm                     => 'dynamic',
      pm_max_children        => 25,
      pm_start_servers       => 4,
      pm_min_spare_servers   => 2,
      pm_max_spare_servers   => 6,
      pm_max_requests        => 500,
      pm_status_path         => '/status',
      ping_path              => '/ping',
      ping_response          => 'pong',
      env                    => $environments,
      php_flag               => $php_flag,
      php_value              => $php_value
  }



}