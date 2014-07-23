# == Defined Type: check_run task
#
# Sets a variable to be checked by the onlyif paramter of exec.
# 
# === Parameters
# [*task_name*] The name of the task.
# [*user*] The user to run the exec command as.
# [*group*] The group that the exec command should run under.
# [*timeout*] If set, sets the maximum time the command will run 
#             Otherwise, uses puppet defined default timeout.
# [*environment*] Sets the environment for the exec command.
# [*returns*] sets the value that exec should return.
# [*cwd*] The directory from which to run the command.
# [*root_dir*] The directory in which checkrun puts the file to check if its been run.
# [*exec_command*] The exec command to run.
# 
define check_run::task (
  $task_name    = $title,
  $user         = root,
  $group        = root,
  $returns      = undef,
  $timeout      = undef,
  $environment  = undef,
  $cwd          = undef,
  $root_dir     = $::check_run::root_dir,
  $exec_command
){

  include check_run # sets up the needed directory

  $command = "$check_run::command_path $root_dir/$task_name"

  exec { $task_name:
    command       => $exec_command,
    user          => $user,
    group         => $group,
    timeout       => $timeout,
    environment   => $environment,
    cwd           => $cwd,
    onlyif        => $command,
    returns       => $returns,
  }
  ->
  exec { "/usr/bin/touch $root_dir/$task_name":
    onlyif  => $command,
    require => Exec[$task_name],
  }
}