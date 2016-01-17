class telegraf::plugin::net (
  $interfaces = [],
) {
  telegraf::plugin { '[inputs.net]':
    conf => {
      'interfaces' => any2array($interfaces),
    }
  }
}
