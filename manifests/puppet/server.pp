# == Profile profiles::puppet::server
#
# This profile provides puppetmaster setup.
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be present or absent.
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#

class profiles::puppet::server {

  ## Hiera lookups
  $ensure = hiera('profiles::puppet::server::ensure')
}
