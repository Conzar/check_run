# == Class: check_run
#
# Initializes check_run so that the task defined type can run
#
# === Parameters
#
# === Variables
#
# [*root_dir*] The directory where the task status resolve
# [*command_name*] The command that is used for checking the status
# [*command_path*] The path to the command
#
# === Examples
#
# include check_run
#
# === Authors
#
# Michael Speth <spethm@landcareresearch.co.nz>
#
# === Copyright
# GPLv3
#
class check_run {

  anchor{"check_run::${title}::begin":}
  case $::osfamily {
    'debian','redhat': {
      $root_dir = '/opt/check_run'
      $command_name = 'check_run.bash'
      $command_path = "${root_dir}/${command_name}"
    }
    'windows':{
      $root_dir = '/opt/check_run'
      $command_name = 'check_run.bash'
      $command_path = "${root_dir}/${command_name}"
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }


  file{ $root_dir:
    ensure => directory,
  }

  file{ $command_path:
    ensure  => file,
    mode    => '0755',
    source  => "puppet:///modules/check_run/${command_name}",
    require => File[$root_dir],
  }
}
