#!/bin/bash

readonly root_dir=$(cd $(dirname $0) && cd .. && pwd)
readonly dot_files_path="${root_dir%/}/dots"

echo $dot_files_path

# Create backup directory
exec_datetime=`date '+%Y-%m-%d_%H:%M:%S'`
backup_dir_name=$HOME/backup/$exec_datetime
mkdir -p $backup_dir_name

# Replace to symlinks...
# TODO: ファイルの実体があるかどうか（Symlinkでないか）を検知して、実体がなければスルーしたい
# TODO: バックアップ対象がなければバックアップファイルを作らないようにしたい
for source_path in `find $dot_files_path -type f -name '*'`
do
  target_path="${HOME}${source_path//${dot_files_path}}"
  mv $target_path $backup_dir_name
  ln -s $source_path $target_path
  echo "SUCCESS: $target_path replaced!"
done
