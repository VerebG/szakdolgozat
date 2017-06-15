class backupaws::credentials (
  $aws_region           = $::backupaws::aws_region,
  $aws_bucket_name      = $::backupaws::aws_bucket_name,
  $aws_access_key_id    = $::backupaws::aws_access_key_id,
  $aws_secret_acces_key = $::backupaws::aws_secret_acces_key,
  ){

  file {
    "/root/.aws/":
      ensure  => directory,
      mode    => '0700';
    "/root/.aws/config":
      ensure  => file,
      mode    => '0600',
      content => template('backupaws/aws_config.erb');
  }
}
