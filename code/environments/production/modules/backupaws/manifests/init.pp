class backupaws (
    $ppa_repo             = $backupaws::params::ppa_repo,
    $aws_region           = $backupaws::params::aws_region,
    $aws_bucket_name      = $backupaws::params::aws_bucket_name,
    $aws_access_key_id    = $backupaws::params::aws_access_key_id,
    $aws_secret_acces_key = $backupaws::params::aws_secret_acces_key,
    $backup_type          = $backupaws::params::backup_type,
    $backup_type_select   = $backupaws::params::backup_type_select,
    $backup_description   = $backupaws::params::backup_description,
    $gpg_key              = $backupaws::params::gpg_key,
    $gpg_pass             = $backupaws::params::gpg_pass,
    ) inherits backupaws::params {

    include backupaws::install::packages
    include backupaws::install::reprository
    include backupaws::credentials
    include backupaws::gnupg

    Class['backupaws::install::reprository']
    -> Class['backupaws::install::packages']
    -> Class['backupaws::credentials']
    -> Class['backupaws::gnupg']

    file {
      '/var/run/backup':
        ensure => directory;
      '/root/.duply/':
        ensure  => directory,
        mode    => '0700';
    }
}