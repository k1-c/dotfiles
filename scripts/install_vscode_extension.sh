#!/bin/sh
readonly root_dir=$(cd $(dirname $0) && cd .. && pwd)
readonly extension_source_path="$root_dir/config/vscode/User/extensions"

# Install extentions
cat $extension_source_path | while read line
do
 code --install-extension $line
done

# Export installed extension to extension files
code --list-extensions > $extension_source_path
