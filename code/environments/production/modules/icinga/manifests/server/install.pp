class icinga::server::install {

  case downcase($facts['os']['name'] ) {
    'Ubuntu': {
      contain 'icinga::server::install::ubuntu'
      Class['icinga::server::install::ubuntu']
    }
  }

}