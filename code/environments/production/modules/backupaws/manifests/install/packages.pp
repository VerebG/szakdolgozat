class backupaws::install::packages {
    include backupaws::install::reprository
    package {
        [
            "duplicity",
            "duply",
            "procmail",
            "python-paramiko",
            "expect",
            'python-pip'
        ]:
            ensure    => latest,
	    require   => Exec[apt_update];
        [
            "boto",
            "awscli",
        ]:
            ensure   => installed,
            provider => pip;
    }
}
