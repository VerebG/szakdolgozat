node /gluster0[1-2]/ {

  apt::ppa {
    'ppa:gluster/glusterfs-3.8':
      package_manage => true;
  }

}