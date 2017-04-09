class szakdolgozat::nagios::server (

){

  package {
    [
      'nagios3',
      'nagios-plugins-basic',
      'nagios-plugins-extra'
    ]:
      ensure => present;
  }

  augeas{
    'Enable use external commands for nagios3':
      context => "/files/etc/nagios3/nagios.cfg",
      changes => "set check_external_commands 1";
  }
}