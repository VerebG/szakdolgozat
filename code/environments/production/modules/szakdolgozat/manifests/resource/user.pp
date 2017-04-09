define szakdolgozat::resource::user (
  Enum['present', 'absent'] $ensure,
  Integer $id,
  String $shell,
  String $password,
){

  group {
    $name:
      ensure => $ensure,
      gid    => $id;

  }

  user {
    $name:
      uid        => $id,
      password   => $password,
      home       => "${szakdolgozat::default_vhosts_directory}/${name}",
      managehome => false,
      shell      => $shell,
      require    => Group[$name]
  }

  User <| title == $name |> {
    groups => $name
  }

}