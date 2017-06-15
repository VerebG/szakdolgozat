# Class: timezone::config
# ===========================
#
# Applies configuration for `::timezone` class to system.
#
# Parameters
# ----------
#
# * `timezone`
# Name of the desired timezone.
#
# * `hw_utc`
# Is the hardware clock set to UTC?
#
# * `zoneinfo_dir`
# Path to directory where timezone information is stored.
#
# * `localtime_file`
# The file which will be symlinked or a copy of the actual timezone file in the
# timezone information directory.
#
# * `localtime_file_type`
# Determines if `localtime_file` will be a `file` or `link`.
#
# * `timezone_file`
# Some operating systems stored timezone in this file with additional settings.
#
# * `timezone_file_template`
# If using a `timezone_file`, a template for the files' content can be used.
#
# * `timezone_file_comments`
# If the timezone file supports comments.
#
# * `timezone_update`
# Signals if an update to the timezone requires execution of an update command.
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2016 Daniel S. Reichenbach <https://kogitoapp.com>
#
class timezone::config (
  $timezone               = $timezone::timezone,
  $hw_utc                 = $timezone::hw_utc,
  $package_ensure         = $timezone::package_ensure,
  $zoneinfo_dir           = $timezone::zoneinfo_dir,
  $localtime_file         = $timezone::localtime_file,
  $localtime_file_type    = $timezone::localtime_file_type,
  $timezone_file          = $timezone::timezone_file,
  $timezone_file_template = $timezone::timezone_file_template,
  $timezone_file_comments = $timezone::timezone_file_comments,
  $timezone_update        = $timezone::timezone_update,
  ) {

  case $package_ensure {
    /(latest)/: {
      $localtime_ensure = 'file'
      $timezone_ensure  = 'file'
    }
    /(present)/: {
      $localtime_ensure = 'file'
      $timezone_ensure  = 'file'
    }
    /(absent)/: {
      $localtime_ensure = 'absent'
      $timezone_ensure  = 'absent'
    }
    default: {
      fail('`package_ensure` parameter must be latest, present or absent')
    }
  }

  if $localtime_ensure == 'absent' {
    file { $localtime_file:
      ensure => $localtime_ensure,
    }
  } else {
    if $localtime_file_type == 'file' {
      file { $localtime_file:
        ensure => $localtime_file_type,
        source => "file://${zoneinfo_dir}${timezone}",
      }
    } else {
      file { $localtime_file:
        ensure => $localtime_file_type,
        target => "${zoneinfo_dir}${timezone}",
      }
    }
  }

  if $timezone_file != false and $timezone_file_template != '' {
    file { $timezone_file:
        ensure  => $timezone_ensure,
        content => template($timezone_file_template),
    }
  }

  if $timezone_update != false and $localtime_ensure != 'absent'{
    exec { 'update_timezone':
      command     => $timezone_update,
      path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
      refreshonly => true,
    }
  }
}
