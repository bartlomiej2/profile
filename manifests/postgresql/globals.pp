# == Profile profile::postgresql::globals
#
# This profile is wrapper for class postgresql::globals from module
# puppetlabs-postgresql module. It allows to choose version of PostreSQL
# installation. This profile doens't install PostgreSQL, just allow to choose
# version.
#
# The pfofile depends on puppetlabs-postgresql module.

#
# === Parameters
#
# [*postgresql_version*]
#   The version of PostgreSQL to install/manage. This is a simple way of
#   providing a specific version such as '9.2' or '8.4' for example.
#
# === Links
#
# * {puppetlabs/postgresql}[https://forge.puppetlabs.com/puppetlabs/postgresql]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::postgresql::globals {

  ## Hiera lookups
  $postgresql_version = hiera('profile::postgresql::globals::postgresql_version')

  # Set the concrete postgresql version
  class { '::postgresql::globals':
    manage_package_repo => true,
    version             => $postgresql_version,
  }
}
