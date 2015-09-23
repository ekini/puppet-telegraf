define telegraf::plugin (
  $order = '10',
  $conf  = undef,
) {
  include telegraf::params

  $plugin_name = $title

  concat::fragment { $plugin_name:
    target  => $telegraf::params::conf_path,
    content => template('telegraf/fragment.erb'),
    order   => $order,
  }

}
