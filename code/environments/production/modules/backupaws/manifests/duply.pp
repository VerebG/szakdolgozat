define backupaws::duply (
	$backuptype        = $::backupaws::backup_type,
	$backuptypeselect  = $::backupaws::backup_type_select,
	$backupdescription = $::backupaws::backup_description,
	$aws_bucket_name   = $::backupaws::aws_bucket_name,
	) {

	file {
		"/root/.duply/${hostname}-${name}":
			ensure  => directory,
			mode    => '0700';
		"/root/.duply/${hostname}-${name}/conf":
			ensure  => file,
			mode    => '0600',
			content => template('backupaws/duply/ve-conf.erb');
		"/root/.duply/${hostname}-${name}/post":
			ensure  => file,
			mode    => '0700',
			content => template('backupaws/duply/ve-post.erb');
		"/root/.duply/${hostname}-${name}/.backupdetails.txt":
			ensure  => file,
			mode    => '0600',
			notify  => Exec["${name}_AWS_S3_Initialization"],
			content => template('backupaws/aws_init.erb');
	}

	exec {
    "${name}_AWS_S3_Initialization":
      cwd 	    => "/root/.duply/${hostname}-${name}/",
      command     => "aws s3 cp .backupdetails.txt s3://${aws_bucket_name}/${hostname}/${name}/backupdetails.txt",
      path        => '/usr/local/bin/',
      require     =>
      [
        Package['awscli'],
        File['/root/.aws/']
      ],
      refreshonly => true;
	}

	case $backuptype {
		"database": {
			if $backuptypeselect == "all" {
		    cron {
					"${name}-${backuptype}-selected":
			    	ensure  => absent;
					"${name}-${backuptype}-all":
			    	ensure  => present,
						command => "duply ${hostname}-${name} backup 2>&1",
						user    => root,
						hour    => fqdn_rand(6),
						minute  => fqdn_rand(59);
        }
		    file {
					"/root/.duply/${hostname}-${name}/pre":
						ensure  => file,
						mode    => '0700',
						content => template('backupaws/duply/ve-pre-all-databases.erb');
		    }
		  } elsif is_array($backuptypeselect) {
        file {
          "/root/.duply/${hostname}-${name}/mysqldatabases.backup":
            ensure  => file,
            mode    => '0700',
            content => template('backupaws/selectedbackups.erb');
          "/root/.duply/${hostname}-${name}/pre":
          ensure  => file,
          mode    => '0700',
          content => template('backupaws/duply/ve-pre-selected-database.erb');
        }
		    cron {
			    "${name}-${backuptype}-all":
			      ensure  => absent;
			    "${name}-${backuptype}-selected":
			    ensure  => present,
            command => "duply ${hostname}-${name} backup 2>&1",
            user    => root,
            hour    => fqdn_rand(6),
            minute  => fqdn_rand(59);
		    }
		  }
	  }
    "files": {
		  if $backuptypeselect == "all" {
			  #TODO: backup complete VM
      } elsif is_array($backuptypeselect) {
        file {
          "/root/.duply/${hostname}-${name}/directory.backup":
            ensure  => file,
            mode    => '0700',
            content => template('backupaws/selectedbackups.erb');
			    "/root/.duply/${hostname}-${name}/pre":
            ensure  => file,
            mode    => '0700',
            content => template('backupaws/duply/ve-pre-selected-directory.erb');
        }
		    cron {
			    "${name}-${backuptype}-all":
			      ensure  => absent;
          "${name}-${backuptype}-selected":
            ensure  => present,
            command => "duply ${hostname}-${name} backup 2>&1",
            user    => root,
            hour    => fqdn_rand(6),
            minute  => fqdn_rand(59);
        }
      }
    }
  }

}
