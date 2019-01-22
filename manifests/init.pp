class telegraf(
  Boolean              $manage_service = true,
                       $version = 'installed',
                       $telegraf_hostname = $::hostname,
  String               $package_name = 'telegraf',
  Optional[Hash]       $package_options = undef,
  String               $service_name = 'telegraf',
  Stdlib::Absolutepath $conf_path = $telegraf::params::conf_path,
  Array[String]        $plugins = ['mem', 'cpu', 'disk', 'swap', 'system', 'io', 'net'],
                       $tags = undef,
                       $interval = '10s',
) inherits telegraf::params {
  package { $package_name:
    ensure => $version,
    name   => $package_name,
    *      => $package_options
  } ~>
  concat { $conf_path:
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
    target  => $conf_path,
  }
  if $manage_service {
    service { $service_name:
      ensure  => running,
      enable  => true,
      name    => $service_name,
      require => [Package[$package_name], Concat[$conf_path], ],
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
  $plugins.each |$plugin| {
    include "telegraf::plugin::${plugin}"
  }
}
