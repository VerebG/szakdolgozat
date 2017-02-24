class nagios::server::install::ubuntu (
  String $ppa_repo,
  Boolean $override_default_repo_priority,
  Integer $apt_backport_pin = $override_default_repo_priority ? {
    true  => 500,
    false => 200,
  },
  Tuple[String] $packages,
){

  assert_private()

  package {
    $packages:
      ensure  => latest;
    'software-properties-common':
      ensure  => latest;
  }

  apt::ppa {
    $ppa_repo:
      ;
  }

  class {
    'apt::backports':
      pin => $apt_backport_pin;
  }

  Package['software-properties-common']
    -> Apt::Ppa[$ppa_repo]
    -> Class['apt::backports']
    -> Class['apt::update']
    -> Package[$packages]

}