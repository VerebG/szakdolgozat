class szakdolgozat::nagios::server (

){

  $tag = 'nagios-server'

  package {
    [
      'nagios3',
      'nagios-plugins-basic',
      'nagios-plugins-extra',
      'apache2',
      'libapache2-mod-fastcgi'
    ]:
      ensure => present,
      tag    => $tag;
  }

  service {
    [
      'apache2',
      'nagios3'
    ]:
      ensure => running,
      enable => true;
  }

  file {
    default: * => {
      tag     => $tag
    };
    '/etc/apache2/sites-enabled/nagios.conf':
      ensure  => file,
      source  => 'puppet:///modules/szakdolgozat/nagios/server/apache.conf',
      notify  => Service['apache2'];
    '/etc/apache2/sites-enabled/000-default.conf':
      ensure  => absent,
      notify  => Service['apache2'];
    '/etc/nagios3/objects':
      ensure  => directory,
      owner   => 'nagios',
      group   => 'nagios',
      tag     => 'nagios-directory-requirements';
    [
      "/etc/nagios3/conf.d/contacts_nagios2.cfg",
      "/etc/nagios3/conf.d/extinfo_nagios2.cfg",
      "/etc/nagios3/conf.d/generic-host_nagios2.cfg",
      "/etc/nagios3/conf.d/generic-service_nagios2.cfg",
      "/etc/nagios3/conf.d/hostgroups_nagios2.cfg",
      "/etc/nagios3/conf.d/localhost_nagios2.cfg",
      "/etc/nagios3/conf.d/services_nagios2.cfg",
      "/etc/nagios3/conf.d/timeperiods_nagios2.cfg"
    ]:
      ensure  => absent,
      tag     => 'nagios-directory-requirements',
      notify  => Service['nagios3'];
    '/etc/nagios3/nagios.cfg':
      ensure  => file,
      source  => 'puppet:///modules/szakdolgozat/nagios/server/nagios.cfg',
      notify  => Service['nagios3'];
  }

  Package <| tag == $tag |>
  -> File <| tag == 'nagios-directory-requirements' |>
  -> File <| tag == $tag |>
  -> Nagios_host <<||>>
  -> Nagios_hostextinfo <<||>>
  -> Nagios_service <<||>>
  -> resources {
    [ "nagios_service", "nagios_servicegroup", "nagios_host" ]:
      purge => true;
  }


}