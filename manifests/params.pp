#
class telegraf::params {
  case $::osfamily {
    'Debian': {
      $package   = 'telegraf'
      $service   = 'telegraf'
      $provider  = 'apt'
      $conf_path = '/etc/telegraf/telegraf.conf'
    }
    'RedHat': {
      $package   = 'telegraf'
      $service   = 'telegraf'
      $provider  = 'yum'
      $conf_path = '/etc/telegraf/telegraf.conf'
    }
    default: {
      fail("${::osfamily} is not supported.")
    }
  }
}
