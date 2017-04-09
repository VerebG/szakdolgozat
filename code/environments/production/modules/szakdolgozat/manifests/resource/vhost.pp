define szakdolgozat::resource::vhost (
  String $listen_ip,
  String $www_root = "${::szakdolgozat::default_vhosts_directory}/${name}/www",
  String $server_name
) {

  nginx::resource::server {
    $server_name:
      ensure                => present,
      listen_ip             => [ $listen_ip ],
      listen_port           => 80,
      www_root              => $www_root,
      index_files           => [ 'index.php' ],
      access_log            => "${::szakdolgozat::default_vhosts_directory}/${name}/logs/nginx_access.log",
      error_log             => "${::szakdolgozat::default_vhosts_directory}/${name}/logs/nginx_error.log",
  }

  nginx::resource::location {
    "${name}_root":
      ensure          => present,
      server          => $server_name,
      location        => '~ \.php$',
      index_files     => ['index.php', 'index.html', 'index.htm'],
      fastcgi         => $name,
      fastcgi_index   => 'index.php',
      fastcgi_param   => {
        'SCRIPT_FILENAME'   => '$document_root$fastcgi_script_name',
        'QUERY_STRING'      => '$query_string',
        'REQUEST_METHOD'    => '$request_method',
        'CONTENT_TYPE'      => '$content_type',
        'CONTENT_LENGTH'    => '$content_length',
        'SCRIPT_NAME'       => '$fastcgi_script_name',
        'REQUEST_URI'       => '$request_uri',
        'DOCUMENT_URI'      => '$document_uri',
        'DOCUMENT_ROOT'     => '$document_root',
        'SERVER_PROTOCOL'   => '$server_protocol',
        'GATEWAY_INTERFACE' => 'CGI/1.1',
        'SERVER_SOFTWARE'   => 'nginx/$nginx_version',
        'REMOTE_ADDR'       => '$remote_addr',
        'REMOTE_PORT'       => '$remote_port',
        'SERVER_ADDR'       => '$server_addr',
        'SERVER_PORT'       => '$server_port',
        'SERVER_NAME'       => '$server_name',
        'REDIRECT_STATUS'   => '200',
      }
  }

}