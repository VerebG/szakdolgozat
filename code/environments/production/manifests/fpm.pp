node /fpm0[1-2]/ {

  include ::szakdolgozat
  include ::szakdolgozat::mount

  $php = lookup('php', Hash, 'deep')

  class {
    ::szakdolgozat::fpm:
      pools      => $php['pools'],
      extensions => $php['extensions'];
    ::mysql::client:
      package_name   => 'mysql-client-5.7',
      package_ensure => '5.7.18-0ubuntu0.16.04.1';
  }

  Class['::szakdolgozat']
  -> Class['::szakdolgozat::mount']
  -> Class['::szakdolgozat::fpm']

}