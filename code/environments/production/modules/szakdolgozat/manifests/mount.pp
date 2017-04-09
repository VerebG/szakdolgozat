class szakdolgozat::mount {

  file {
    $::szakdolgozat::default_vhosts_directory:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
      tag    => 'mount-requirements';
  }

  package {
    [ 'glusterfs-client', 'attr' ]:
      ensure => latest,
      tag    => 'mount-requirements';
  }

  #bugfix for LXC contanier
  exec {
    'ENABLE_FUSE_IN_CONTAINER':
      command => 'mknod -m 666 /dev/fuse c 10 229',
      onlyif  => 'test ! -e /dev/fuse';
  }

  mount {
    $::szakdolgozat::default_vhosts_directory:
      ensure    => mounted,
      atboot    => true,
      target    => '/etc/fstab',
      fstype    => glusterfs,
      remounts  => false,
      device    => "${::szakdolgozat::params::glusterfs_host}:${::szakdolgozat::params::glusterfs_share}";
  }

  File <| tag == 'mount-requirements' |>
  -> Package <| tag == 'mount-requirements' |>
  -> Exec['ENABLE_FUSE_IN_CONTAINER']
  -> Mount <| fstype == glusterfs |>

}