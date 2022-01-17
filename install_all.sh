#!/bin/bash
readonly script_dir=$(cd $(dirname $0); pwd)
readonly install_scripts_path="$script_dir/install_scripts/"

# All install script files execute
for file in `find $install_scripts_path -type f -name '*'`
do
  bash "${file}"
done
