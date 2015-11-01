define telegraf::plugin (
  $order      = '10',
  $conf       = undef,
  $plugin_name  = undef,
) {
  include telegraf::params

  if $plugin_name {
    $real_name = $plugin_name
  } else {
    $real_name = $title
  }
  $plugin_file = regsubst($title, '\[|\]', '', 'G')

  concat::fragment { $plugin_file:
    target  => $telegraf::params::conf_path,
    content => template('telegraf/fragment.erb'),
    order   => $order,
  }

}
