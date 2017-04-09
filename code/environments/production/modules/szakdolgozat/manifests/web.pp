class szakdolgozat::web (
  Hash $upstreams,
  Hash $vhosts
){

  include ::nginx
  include ::szakdolgozat::mount

  $upstreams.each |String $upstream, Hash $parameters| {
    Resource[szakdolgozat::resource::upstream] {
      $upstream: * => $parameters;
      default:   * => {
        upstream_fail_timeout => $::szakdolgozat::upstream_fail_timeout,
        upstream_max_fails    => $::szakdolgozat::upstream_max_fails
      }
    }
  }

  $vhosts.each |String $vhost, Hash $parameters| {
    Resource[szakdolgozat::resource::vhost] {
      $vhost:  * => $parameters;
    }
  }

}