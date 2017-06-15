class filesynchronization::params {

    #Mode of synchronization
    # - both:        server already to work as sender or receiver
    # - share only:  server can only receiving files
    # - sender only: server can only sending files with lsyncd or manually (rsync command)
    #Default: both
    $mode                    = 'both'

    #RSYNC CONFIGURATION

    #Shares config location
    $rsyncd_conf_file        = '/etc/rsyncd.conf'

    #Daemon config location
    $rsyncd_daemon_conf_file = '/etc/default/rsync'

    #Logging dir
    $rsyncd_log_dir          = '/var/log/rsync'

    #Start on boot options
    $rsyncd_start_on_boot    = true

    #Chroot
    $rsyncd_use_chroot       = 'yes'

    #Process owner uid 
    $rsyncd_uid              = 'root'

    #Process owner gid
    $rsyncd_gid              = 'root'

    #Listen IPv4 address
    $rsyncd_ipv4_listen      = '127.0.0.1'

    #Sharing is read only?
    $rsyncd_share_read_only  = 'no'

    #Sharing is write only?
    $rsyncd_share_write_only = 'no'

    #Incoming file's chmod
    $rsyncd_incoming_chmod   = 0644

    #Outgoing file's chmod
    $rsyncd_outgoing_chmod   = 0644


    #LSYNCD CONFIGURATION

    $lsyncd_conf_dir         = '/etc/lsyncd'

    $lsyncd_conf_file        = '/etc/lsyncd/lsyncd.conf.lua'

    $lsyncd_log_dir          = '/var/log/lsyncd'

    $lsyncd_status_file      = '/var/log/lsyncd/lsyncd.stat'


}