# check_run

Author: Michael Speth <spethm@landcareresearch.co.nz>

## About

Manages tasks checking if a task has run or if a task should run.  This is primarily useful for running a one off command for 
installation.

## Usage

**Make sure that check_run is included in order to use its variables**

    include check_run

    $task_name = 'test_run'

**Runs the command only once and will not execute after this one**

    check_run::task{$task_name:
      exec_command => "/usr/bin/touch $check_run::root_dir/ttt",
    }


## License

GPL version 3

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, [see](http://www.gnu.org/licenses/).
