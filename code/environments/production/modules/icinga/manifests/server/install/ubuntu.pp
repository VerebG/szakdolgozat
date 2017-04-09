class icinga::server::install::ubuntu (
  String $ppa_repo,
  Boolean $override_default_repo_priority,
  Integer $apt_backport_pin = $override_default_repo_priority ? {
    true  => 500,
    false => 200,
  },
  Tuple[String, 1, default] $packages,
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

}





