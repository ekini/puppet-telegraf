class telegraf::outputs {
  telegraf::plugin { 'outputs':
    order => '02',
  }

}
class telegraf::outputs::amqp (
  $url         = undef,
  $exchange    = '',
  $routing_tag = '',
) {
  include telegraf::outputs

  telegraf::plugin { 'outputs.amqp':
    order => '03',
    conf  => {
      'url'         => $url,
      'exchange'    => $exchange,
      'routing_tag' => $routing_tag,
    }
  }
}
