# == Profile profile::apache
#
# This profile is wrapper for puppetlabs-apache module. It contains common
# Apache settings. This profile should be inherited by other profile to override
# settings.
#
# The pfofile depends on puppetlabs-apache module.
#
# === Parameters
#
# [*service_ensure*]
#   Whether a service should be running.
#   Valid values are stopped (also called false), running (also called true).
#
# [*service_enable*]
#   Whether a service should be enabled to start at boot. This property behaves
#   quite differently depending on the platform; wherever possible, it relies on
#   local tools to enable or disable a given service.
#   Valid values are true, false, manual.
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#

class profile::apache {

  ## Hiera lookups
  $service_ensure = hiera('profile::apache::service_ensure')
  $service_enable = hiera('profile::apache::service_enable')

  class { '::apache':
    service_ensure    => $service_ensure,
    service_enable    => $service_enable,
    server_signature  => 'Off',
  }

}
