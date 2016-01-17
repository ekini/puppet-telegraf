class telegraf::outputs::amqp (
  $url         = undef,
  $exchange    = '',
  $routing_tag = '',
  $ssl_ca      = '',
  $ssl_cert    = '',
  $ssl_key     = '',
) {

  telegraf::plugin { '[outputs.amqp]':
    order => '03',
    conf  => {
      'url'         => $url,
      'exchange'    => $exchange,
      'routing_tag' => $routing_tag,
      'ssl_ca'      => $ssl_ca,
      'ssl_cert'    => $ssl_cert,
      'ssl_key'     => $ssl_key,
    }
  }
}
