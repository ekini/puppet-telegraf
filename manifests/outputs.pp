class telegraf::outputs::amqp (
  $url              = undef,
  $exchange         = '',
  $routing_tag      = '',
  $ssl_ca           = '',
  $ssl_cert         = '',
  $ssl_key          = '',
  $precision        = 'n',
  $retention_policy = 'default',
  $database         = 'telegraf',
) {

  telegraf::plugin { '[outputs.amqp]':
    order => '03',
    conf  => {
      'url'              => $url,
      'exchange'         => $exchange,
      'routing_tag'      => $routing_tag,
      'ssl_ca'           => $ssl_ca,
      'ssl_cert'         => $ssl_cert,
      'ssl_key'          => $ssl_key,
      'precision'        => $precision,
      'retention_policy' => $retention_policy,
      'database'         => $database,
    }
  }
}
