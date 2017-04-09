Package {
  provider => apt
}

Exec {
  path => '/opt/puppetlabs/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
}

include ::stdlib
include ::apt
include ::szakdolgozat

$networks = lookup('network', Hash, 'deep')
$users = lookup('users', Hash, 'deep')

class {
  '::szakdolgozat::network':
    networks => $networks;
  '::szakdolgozat::user':
    users    => $users;
}

