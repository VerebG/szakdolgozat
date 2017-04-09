class szakdolgozat::fpm (
  Hash $pools,
  Hash $extensions
) {

  include ::phpfpm
  include ::szakdolgozat::mount

  $extensions.each |String $extension, Hash $parameters| {
    Resource[szakdolgozat::resource::extension] {
      $extension:   * => $parameters;
    }
  }

  $pools.each |String $pool, Hash $parameters| {
    Resource[szakdolgozat::resource::fpm] {
      $pool:   * => $parameters;
    }
  }

}