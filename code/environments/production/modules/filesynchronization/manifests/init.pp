# Class: filesynchronization
# ===========================
#
# Full description of class filesynchronization here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'filesynchronization':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class filesynchronization (
  $mode                    = $filesynchronization::params::mode,
  $rsyncd_conf_file        = $filesynchronization::params::rsyncd_conf_file,
  $rsyncd_daemon_conf_file = $filesynchronization::params::rsyncd_daemon_conf_file,
  $rsyncd_start_on_boot    = $filesynchronization::params::rsyncd_start_on_boot,
  $rsyncd_use_chroot       = $filesynchronization::params::rsyncd_use_chroot,
  $rsyncd_uid              = $filesynchronization::params::rsyncd_uid,
  $rsyncd_gid              = $filesynchronization::params::rsyncd_gid,
  $rsyncd_ipv4_listen      = $filesynchronization::params::rsyncd_ipv4_listen,
  $rsyncd_share_read_only  = $filesynchronization::params::rsyncd_share_read_only,
  $rsyncd_share_write_only = $filesynchronization::params::rsyncd_share_write_only,
  $rsyncd_incoming_chmod   = $filesynchronization::params::rsyncd_incoming_chmod,
  $rsyncd_outgoing_chmod   = $filesynchronization::params::rsyncd_outgoing_chmod,
  $rsyncd_log_dir          = $filesynchronization::params::rsyncd_log_dir,
  $lsyncd_conf_dir	       = $filesynchronization::params::lsyncd_conf_dir,
  $lsyncd_conf_file        = $filesynchronization::params::lsyncd_conf_file,
  $lsyncd_log_dir          = $filesynchronization::params::lsyncd_log_dir,
  $lsyncd_status_file      = $filesynchronization::params::lsyncd_status_file,
) inherits filesynchronization::params {

  validate_ip_address($rsyncd_ipv4_listen)
  validate_hash($rsyncd_shares)
  validate_hash($lsyncd_targets)

  case $mode {
    'both': {
      $rsyncd_ensure  = enabled
      $rsyncd_service = running
      $lsyncd_ensure  = enabled
      $lsyncd_service = running
    }
    'share only': {
      $rsyncd_ensure  = enabled
      $rsyncd_service = running
      $lsyncd_ensure  = disabled
      $lsyncd_service = stopped
    }
    'sender only': {
      $rsyncd_ensure  = disabled
      $rsyncd_service = stopped
      $lsyncd_ensure  = enabled
      $lsyncd_service = running
    }
  }

}
