class backupaws::install::softmanager {
    package {
        "software-properties-common":
            ensure    => latest;
        
    }
}