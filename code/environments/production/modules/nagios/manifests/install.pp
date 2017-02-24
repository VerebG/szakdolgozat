class nagios::install {

  case downcase($facts['os']['name'] ) {
    'Ubuntu': {
      contain 'nagios::server::install::ubuntu'
      Class['nagios::server::install::ubuntu']
    }
  }

}