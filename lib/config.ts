import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

const projectRoot = $.path(import.meta.url).parent()!.parent()!;
const srcPath = projectRoot.join("config");
const homeDir = $.path(Deno.env.get("HOME")!);

// Create backup directory with timestamp
const execDatetime = new Date().toISOString().replace(/[:.]/g, "-");
const backupDir = projectRoot.join(".backup", execDatetime);
await backupDir.ensureDir();

// Register function to create symlinks
async function register(origin: string, target: string) {
  const targetPath = $.path(target);
  const originPath = $.path(origin);
  
  // Backup existing file if it exists and is not a symlink
  if (await targetPath.exists()) {
    const stat = await targetPath.lstat();
    if (stat && !stat.isSymlink) {
      const backupTarget = backupDir.join(targetPath.basename());
      await targetPath.rename(backupTarget);
    } else {
      await targetPath.remove();
    }
  }
  
  // Ensure parent directory exists
  await targetPath.parent()!.ensureDir();
  
  // Create symlink
  await targetPath.createSymlinkTo(originPath.toString());
  console.log(`🔗 Linked ${target} -> ${origin}`);
}

console.log("🔧 Setting up configuration symlinks...");

// Git
await register(
  srcPath.join("git/.gitconfig").toString(),
  homeDir.join(".gitconfig").toString()
);

// Fish shell configuration
const fishConfigDir = homeDir.join(".config/fish");
await fishConfigDir.ensureDir();
await fishConfigDir.join("completions").ensureDir();
await fishConfigDir.join("conf.d").ensureDir();
await fishConfigDir.join("functions").ensureDir();

await register(
  srcPath.join("fish/completions/fisher.fish").toString(),
  fishConfigDir.join("completions/fisher.fish").toString()
);
await register(
  srcPath.join("fish/completions/poetry.fish").toString(),
  fishConfigDir.join("completions/poetry.fish").toString()
);
await register(
  srcPath.join("fish/conf.d/omf.fish").toString(),
  fishConfigDir.join("conf.d/omf.fish").toString()
);
await register(
  srcPath.join("fish/functions/fisher.fish").toString(),
  fishConfigDir.join("functions/fisher.fish").toString()
);
await register(
  srcPath.join("fish/config.fish").toString(),
  fishConfigDir.join("config.fish").toString()
);
await register(
  srcPath.join("fish/fish_variables").toString(),
  fishConfigDir.join("fish_variables").toString()
);

// Neovim
const nvimConfigDir = homeDir.join(".config/nvim");
await nvimConfigDir.ensureDir();
const vimAutoloadDir = homeDir.join(".vim/autoload");
await vimAutoloadDir.ensureDir();

await register(
  srcPath.join("nvim/init.lua").toString(),
  nvimConfigDir.join("init.lua").toString()
);
await register(
  srcPath.join("nvim/coc-settings.json").toString(),
  nvimConfigDir.join("coc-settings.json").toString()
);

// Tmux
const tmuxDir = homeDir.join(".tmux");
await tmuxDir.ensureDir();

await register(
  srcPath.join("tmux/.tmux.conf").toString(),
  homeDir.join(".tmux.conf").toString()
);
await register(
  srcPath.join("tmux/new-session.sh").toString(),
  tmuxDir.join("new-session.sh").toString()
);

// Obsidian (TODO: Make vault path dynamic)
const obsidianVimrcPath = homeDir.join("Documents/Primary/.obsidian.vimrc");
await obsidianVimrcPath.parent()!.ensureDir();
await register(
  srcPath.join("obsidian/.obsidian.vimrc").toString(),
  obsidianVimrcPath.toString()
);

// Ulauncher
const ulauncherConfigDir = homeDir.join(".config/ulauncher");
await ulauncherConfigDir.ensureDir();

await register(
  srcPath.join("ulauncher/extensions.json").toString(),
  ulauncherConfigDir.join("extensions.json").toString()
);
await register(
  srcPath.join("ulauncher/settings.json").toString(),
  ulauncherConfigDir.join("settings.json").toString()
);
await register(
  srcPath.join("ulauncher/shortcuts.json").toString(),
  ulauncherConfigDir.join("shortcuts.json").toString()
);

// VSCode
const vscodeUserDir = homeDir.join(".config/Code/User");
await vscodeUserDir.ensureDir();

await register(
  srcPath.join("vscode/User/extensions").toString(),
  vscodeUserDir.join("extensions").toString()
);
await register(
  srcPath.join("vscode/User/keybindings.json").toString(),
  vscodeUserDir.join("keybindings.json").toString()
);
await register(
  srcPath.join("vscode/User/settings.json").toString(),
  vscodeUserDir.join("settings.json").toString()
);

// GitUI
const gituiConfigDir = homeDir.join(".config/gitui");
await gituiConfigDir.ensureDir();

await register(
  srcPath.join("gitui/key_bindings.ron").toString(),
  gituiConfigDir.join("key_bindings.ron").toString()
);
await register(
  srcPath.join("gitui/theme.ron").toString(),
  gituiConfigDir.join("theme.ron").toString()
);

// Zsh
await register(
  srcPath.join("zsh/.zshrc").toString(),
  homeDir.join(".zshrc").toString()
);
await register(
  srcPath.join("zsh/.p10k.zsh").toString(),
  homeDir.join(".p10k.zsh").toString()
);

// Clean up empty backup directory
try {
  const backupContents = [];
  for await (const entry of backupDir.readDir()) {
    backupContents.push(entry);
  }
  if (backupContents.length === 0) {
    await backupDir.remove();
  }
} catch {
  // Ignore errors when cleaning up backup directory
}

console.log("✅ Configuration symlinks setup completed!");