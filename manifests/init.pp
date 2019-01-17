class telegraf(
  $manage_service = true,
  $version = installed,
  $telegraf_hostname = $::hostname,
  $package_name = $telegraf::params::package,
  $service_name = $telegraf::params::service,
  $default_plugins = ['mem', 'cpu', 'disk', 'swap', 'system', 'io', 'net'],
  $tags = undef,
  $interval = '10s',
  $pkg_repo = undef
) inherits telegraf::params {


  if $pkg_repo {
    $pkg_options = ["--enablerepo", $pkg_repo]
  } else {
    $pkg_options = [""]
  }

  package { $package_name:
    ensure   => $version,
    name     => $package_name,
    provider => $telegraf::params::provider,
    install_options => $pkg_options,

  } ~>
  concat { $telegraf::params::conf_path:
    ensure  => present,
    owner   => 'telegraf',
    group   => 'telegraf',
    mode    => '0644',
    before  => Service[$service_name],
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  concat::fragment { 'telegraf_header':
    order   => '00',
    content => "## Managed by Puppet ###\n",
    target  => $telegraf::params::conf_path,
  }

  if $manage_service {
    service { $service_name:
      ensure  => running,
      enable  => true,
      name    => $service_name,
      require => [Package[$package_name], Concat[$telegraf::params::conf_path], ],
    }
  }

  telegraf::plugin { 'global_tags':
    order => '04',
    conf  => $tags,
  }

  telegraf::plugin { 'agent':
    order => '01',
    conf  => {
      'interval'  => $interval,
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
