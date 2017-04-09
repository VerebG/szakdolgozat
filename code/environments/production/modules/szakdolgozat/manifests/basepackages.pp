class szakdolgozat::basepackages {

  $packages_will_install = [
    'mc', 'htop', 'iptraf', 'augeas-tools'
  ]

  $packages_will_purge = [
    'rpcbind'
  ]

  package {
    $packages_will_install:
      ensure => present;
    $packages_will_purge:
      ensure => absent;
  }

  Package[$packages_will_purge]
  -> Package[$packages_will_install]

}