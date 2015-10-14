define telegraf::plugin (
  $order = '10',
  $conf  = undef,
) {
  include telegraf::params

  $plugin_file = regsubst($title, '\[|\]', '', 'G')
  $plugin_name = $title

  concat::fragment { $plugin_file:
    target  => $telegraf::params::conf_path,
    content => template('telegraf/fragment.erb'),
    order   => $order,
  }

}
