class telegraf(
  $manage_service = true,
  $version = installed,
  $telegraf_hostname = $::hostname,
  $package_name = $telegraf::params::package,
  $service_name = $telegraf::params::service,
  $default_plugins = ['mem', 'cpu', 'disk', 'swap', 'system', 'io', 'net'],
  $tags = undef,
) inherits telegraf::params {

  package { $package_name:
    ensure   => $version,
    name     => $package_name,
    provider => $telegraf::params::provider
  } ->
  concat { $telegraf::params::conf_path:
    ensure => present,
    owner  => 'telegraf',
    group  => 'telegraf',
    mode   => '0644',
    before => Service[$service_name],
    notify => Service[$service_name],
  }

  concat::fragment { 'header':
    order   => '00',
    content => "## Managed by Puppet ###\n",
    target  => $telegraf::params::conf_path,
  }

  if $manage_service {
    service { $service_name:
      ensure  => running,
      enable  => true,
      name    => $service_name,
      require => Package[$package_name],
    }
  }

  telegraf::plugin { 'tags':
    order => '04',
    conf  => $tags,
  }

  telegraf::plugin { 'agent':
    order => '01',
    conf  => {
      'interval'  => '10s',
      'utc'       => true,
      'precision' => 'n',
      'debug'     => false,
      'hostname'  => $telegraf_hostname,
    }
  }

  includer { $default_plugins: }
}

define includer {
  include "telegraf::plugin::${title}"
}
