#!/bin/bash

readonly root_dir=$(cd $(dirname $0) && cd .. && pwd)
readonly dot_files_path="$root_dir/dots/"

# Replace to symlinks...
for source_path in `find $dot_files_path -type f -name '*'`
do
  target_path="$HOME/${source_path//${dot_files_path}}"
  rm -r "$target_path"
  ln -s "$source_path" "$target_path"
  echo "SUCCESS: $target_path replaced!"
done
