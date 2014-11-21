# == Profile profile::postgresql::server
#
# This profile is wrapper for puppetlabs-postgresql module. It contains common
# PostgreSQL settings. This profile should be inherited by other profile to override
# settings.
#
# The pfofile depends on puppetlabs-postgresql module.

#
# === Parameters
#
#
#
# === Links
#
# * {puppetlabs/postgresql}[https://forge.puppetlabs.com/puppetlabs/postgresql]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::postgresql::server {
  # Install PostgreSQL server
  class { '::postgresql::server': }
}
