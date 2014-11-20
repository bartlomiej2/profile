# == Profile profile::apache::mod::ssl
#
# This profile is wrapper for puppetlabs-apache module. It contains common
# Apache SSL settings. This profile should be inherited by other profile to
# override settings.
#
# The pfofile depends on puppetlabs-apache module.
#
# === Parameters
#
# [*ssl_compression*]
#   Boolean. Controls if the SSL compression shall be enabled or disabled.
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#

class profile::apache::mod::ssl {
  ## Hiera lookups
  $ssl_compression = hiera('profile::apache::mod::ssl::ssl_compression')

  class { '::apache::mod::ssl':
    ssl_compression => $ssl_compression,
    ssl_options     => [ 'StdEnvVars', 'ExportCertData' ],
    ssl_protocol    => [ 'all', '-SSLv2' ],
  }

}
