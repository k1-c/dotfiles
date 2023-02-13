readonly project_root=$(cd $(dirname $0) && cd .. && pwd)
readonly src_path="${project_root%/}/config"

exec_datetime=`date '+%Y-%m-%d_%H:%M:%S'`
backup_dir=${project_root}/.backup/${exec_datetime}
mkdir -p $backup_dir

# arg1: origin file path, arg2: target path to symlink
function register() {
  origin=$1
  target=$2
  # file exists and not symlink
  if [ -f $target ] && [ ! -h $target ]; then mv $target $backup_dir; fi
  # if it's a symlink, remove old file and place new symlink
  if [ -h $target ]; then rm $target; fi
  ln -s $origin $target
}

# TODO: Obsidian vim rc
# TODO: Place Symlinks recursively each directory

# git
register ${src_path}/git/.gitconfig ${HOME}/.gitconfig

# fish
if [ ! -d ${HOME}/.config/fish ]; then mkdir -p ${HOME}/.config/fish; fi
if [ ! -d ${HOME}/.config/fish/completions ]; then mkdir -p ${HOME}/.config/fish/completions; fi
if [ ! -d ${HOME}/.config/fish/conf.d ]; then mkdir -p ${HOME}/.config/fish/conf.d; fi
if [ ! -d ${HOME}/.config/fish/functions ]; then mkdir -p ${HOME}/.config/fish/functions; fi
register ${src_path}/fish/completions/fisher.fish ${HOME}/.config/fish/fisher.fish
register ${src_path}/fish/completions/poetry.fish ${HOME}/.config/fish/poetry.fish
register ${src_path}/fish/conf.d/omf.fish ${HOME}/.config/fish/conf.d/omf.fish
register ${src_path}/fish/functions/fisher.fish ${HOME}/.config/fish/functions.fisher.fish
register ${src_path}/fish/config.fish ${HOME}/.config/fish/config.fish
register ${src_path}/fish/fish_variables ${HOME}/.config/fish/fish_variables

# nvim
if [ ! -d ${HOME}/.config/nvim ]; then mkdir -p ${HOME}/.config/nvim; fi
register ${src_path}/nvim/init.vim ${HOME}/.config/nvim/init.vim
register ${src_path}/nvim/coc-settings.json ${HOME}/.config/nvim/coc-settings.json
if [ ! -d ${HOME}/.vim/autoload ]; then mkdir -p ${HOME}/.vim/autoload; fi
register ${src_path}/nvim/.vim/autoload/jetpack.vim ${HOME}/.vim/autoload/jetpack.vim

# tmux
register ${src_path}/tmux/.tmux.conf ${HOME}/.tmux.conf

# ulauncher
if [ ! -d ${HOME}/.config/ulauncher ]; then mkdir -p ${HOME}/.config/ulauncher; fi
register ${src_path}/.config/ulauncher/extensions.json ${HOME}/.config/ulauncher/extensions.json
register ${src_path}/.config/ulauncher/settings.json ${HOME}/.config/ulauncher/settings.json
register ${src_path}/.config/ulauncher/shortcuts.json ${HOME}/.config/ulauncher/shortcuts.json

# vscode
if [ ! -d ${HOME}/.config/Code/User ]; then mkdir -p ${HOME}/.config/Code/User; fi
register ${src_path}/.config/Code/User/extensions ${HOME}/.config/Code/User/extensions
register ${src_path}/.config/Code/User/keybindings.json ${HOME}/.config/Code/User/keybindings.json
register ${src_path}/.config/Code/User/settings.json ${HOME}/.config/Code/User/settings.json

# Delete backup directory when empty
if [ -z "`ls $backup_dir`" ]; then rm -r $backup_dir; fi

echo "registration for config files completed."
