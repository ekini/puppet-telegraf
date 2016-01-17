class telegraf::plugin::cpu (
  $percpu = true,
  $totalcpu = true,
) {
  telegraf::plugin { '[inputs.cpu]':
    conf => {
      'percpu'   => $percpu,
      'totalcpu' => $totalcpu,
    }
  }
}
