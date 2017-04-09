define szakdolgozat::resource::upstream (
  Array[String] $members,
  String $upstream_fail_timeout,
  Integer $upstream_max_fails
) {

  nginx::resource::upstream {
    $name:
      members               => $members,
      upstream_fail_timeout => $upstream_fail_timeout,
      upstream_max_fails    => $upstream_max_fails;
  }

}