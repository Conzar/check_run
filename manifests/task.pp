# == Defined Type: check_run task
#
# Sets a variable to be checked by the onlyif paramter of exec.
# 
# === Parameters
# [*exec_command*]
#   The exec command to run.
#
# [*task_name*]
#   The name of the task.
#
# [*user*]
#   The user to run the exec command as.
#
# [*group*]
#   The group that the exec command should run under.
#
# [*timeout*]
#   If set, sets the maximum time the command will run 
#   Otherwise, uses puppet defined default timeout.
#
# [*environment*]
#   Sets the environment for the exec command.
#
# [*returns*]
#   sets the value that exec should return.
#
# [*cwd*]
#   The directory from which to run the command.
#
# [*root_dir*]
#   The directory in which checkrun puts the file to check if its been run.
# 
define check_run::task (
  $exec_command,
  $task_name    = $title,
  $user         = root,
  $group        = root,
  $returns      = undef,
  $timeout      = undef,
  $environment  = undef,
  $cwd          = undef,
  $root_dir     = $::check_run::root_dir,
){
  anchor{"check_run::task::${title}::begin":}
  case $::osfamily {
    'debian': {
      $touch_cmd_path = '/usr/bin/touch'
    }
    'redhat': {
      $touch_cmd_path = '/bin/touch'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }

  include check_run # sets up the needed directory

  $command = "${check_run::command_path} ${root_dir}/${task_name}"

## TODO, need to silence response if the check command if it doesn't 
## actually change anything!!!!
  exec { $task_name:
    command     => $exec_command,
    user        => $user,
    group       => $group,
    timeout     => $timeout,
    environment => $environment,
    cwd         => $cwd,
    onlyif      => $command,
    returns     => $returns,
    require     => Anchor["check_run::task::${title}::begin"],
  }
  exec { "${touch_cmd_path} ${root_dir}/${task_name}":
    onlyif  => $command,
    user    => 'root',
    group   => 'root',
    require => Exec[$task_name],
  }
  anchor{"check_run::task::${title}::end":
    require => Exec["${touch_cmd_path} ${root_dir}/${task_name}"],
  }
}
