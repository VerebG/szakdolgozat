node 'backup01' {

  include ::szakdolgozat::mount

  $backup = lookup('backup', Hash, 'deep')

  class {
    backupaws:
      aws_region           => $backup['aws_region'],
      aws_bucket_name      => $backup['aws_bucket_name'],
      aws_access_key_id    => $backup['aws_access_key_id'],
      aws_secret_acces_key => $backup['aws_secret_acces_key'],
      gpg_key              => $backup['gpg_key'],
      gpg_pass             => $backup['gpg_pass'];
  }

  Backupaws::Duply <<||>>

}