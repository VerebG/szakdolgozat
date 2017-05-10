node /mysql0[1-2]/ {

  $mysql_server = lookup('mysql_server', Hash, 'deep')

  class {
    '::mysql::server':
      root_password           => $mysql_server['root_password'],
      remove_default_accounts => $mysql_server['remove_default_accounts'],
      override_options        => $mysql_server['override_options'],
      users                   => $mysql_server['users'],
      databases               => $mysql_server['databases'],
      grants                  => $mysql_server['grants'];
  }

}