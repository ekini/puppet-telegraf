### Puppet module to install and configure telegraf --- an OSS influxdb client

Supports telegraf 0.1.9+

Example:

```puppet
class { '::telegraf':
  tags => {
    dc => $::dc,
    # some other tags if you like...
  }
}
class { '::telegraf::outputs::amqp':
  url         => 'amqp://sample_user:sample_password@sample_mq_host:5672/sample_vhost',
  exchange    => 'telegraf',
  routing_tag => 'dc',
}
```
