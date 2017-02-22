class nagios::install (
  String $ppa_repo,
  Boolean $override_default_repo_priority,
  Integer $apt_backport_pin = $override_default_repo_priority ? {
    true  => 500,
    false => 200,
  }
){


  package {
    $::nagios::package_name:
      ensure => latest;
  }

  apt::ppa {
    $ppa_repo:
      ;
  }

  class {
    'apt::backports':
      pin => $apt_backport_pin,
  }

  Apt::Ppa[$ppa_repo] -> Class['apt::backports'] -> Package[$::nagios::package_name]
}