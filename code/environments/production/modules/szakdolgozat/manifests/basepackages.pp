class szakdolgozat::basepackages {

  assert_private()

  $packages_will_install = [
    'mc', 'htop', 'iptraf', 'augeas-tools', 'libfcgi0ldbl'
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