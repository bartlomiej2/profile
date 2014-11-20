# == Profile profile::puppet::puppetdb
#
# This profile is wrapper for puppetlabs-puppetdb module. It contains common
# PuppetDB settings. This profile should be inherited by other profile to override
# settings.
#
# The pfofile depends on puppetlabs-puppetdb module.

#
# === Parameters
#
# [*listen_address*]
#   The address that the web server should bind to for HTTP requests
#   '0.0.0.0' = all
#
# === Links
#
# * {puppetlabs/puppetdb}[https://forge.puppetlabs.com/puppetlabs/puppetdb/dependencies]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::puppet::puppetdb {
  ## Hiera lookups
  $listen_address = hiera('profile::puppet::puppetdb::listen_address')

  include ::puppetdb::master::config
  class { '::puppetdb':
    listen_address => $listen_address,
  }
}
