# == Class: kolab
#
# A basic module to manage kolab
#
# === Parameters
# [*version*]
#   Version to install (Default: 'development')
#
# [*enable*]
#   Should the service be enabled during boot time? (Default: true)
#
# [*start*]
#   Should the service be started by Puppet? (Default: true)
#
class kolab (
  $version = 'development',
  $enable  = true,
  $start   = true,
) {

  class { 'kolab::install': } ->
  class { 'kolab::config': } ~>
  class { 'kolab::service': } ->
  Class['kolab']

}
