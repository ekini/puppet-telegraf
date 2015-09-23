class telegraf::plugin::net (
  $interfaces = [],
) {
  telegraf::plugin { 'net':
    conf => {
      'interfaces' => any2array($interfaces),
    }
  }
}
