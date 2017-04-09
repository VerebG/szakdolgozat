node /fpm0[1-2]/ {

  include ::szakdolgozat
  include ::szakdolgozat::mount

  $php = lookup('php', Hash, 'deep')

  class {
    ::szakdolgozat::fpm:
      pools      => $php['pools'],
      extensions => $php['extensions'];
  }

  Class['::szakdolgozat']
  -> Class['::szakdolgozat::mount']
  -> Class['::szakdolgozat::fpm']

}