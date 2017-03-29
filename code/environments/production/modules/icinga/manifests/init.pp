# Class: icinga
# ===========================
#
# Full description of class icinga here.
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
#    class { 'icinga':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Gabor Vereb <>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class icinga (
  String $config_dir,
  String $service_name,
  String $default_package_provider,
){

  Package {
    provider => $::icinga::default_package_provider,
  }

}