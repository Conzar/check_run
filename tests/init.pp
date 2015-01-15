include check_run

$task_name = 'test_run'

check_run::task{$task_name:
  exec_command => "/usr/bin/touch ${check_run::root_dir}/ttt",
}