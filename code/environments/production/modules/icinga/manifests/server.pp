class icinga::server {

  contain ::icinga::service
  contain ::icinga::server::install

  Class['icinga::server::install']
    ~> Class['::icinga::service']

}