define szakdolgozat::resource::extension (
  Enum['present', 'absent'] $ensure,
) {

  package {
    $name:
      ensure => $ensure;
  }

}