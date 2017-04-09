class szakdolgozat::user (
  Hash $users
){

  $users.each |String $user, Hash $parameters| {
    Resource[szakdolgozat::resource::user] {
      $user:   * => $parameters;
      default: * => {
        password => $::szakdolgozat::user_default_password,
        shell    => $::szakdolgozat::user_default_shell
      };
    }
  }

}