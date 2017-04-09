node /web0[1-2]/ {

  include ::szakdolgozat

  $pools = lookup('fpm_pools', Hash, 'deep')
  $vhosts = lookup('vhosts', Hash, 'deep')

  class {
    ::szakdolgozat::web:
      upstreams => $pools,
      vhosts    => $vhosts;
  }

}