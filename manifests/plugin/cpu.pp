class telegraf::plugin::cpu (
  $percpu = true,
  $totalcpu = true,
) {
  telegraf::plugin { 'cpu':
    conf => {
      'percpu'   => $percpu,
      'totalcpu' => $totalcpu,
    }
  }
}
