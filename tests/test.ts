import $ from "https://deno.land/x/dax@0.39.2/mod.ts";
import { assert } from "https://deno.land/std@0.213.0/assert/mod.ts";

const homeDir = $.path(Deno.env.get("HOME")!);

// Helper function to check if a command exists
async function commandExists(command: string): Promise<boolean> {
  try {
    await $`${command} --version`;
    return true;
  } catch {
    return false;
  }
}

// Helper function to check if file is symlinked
async function isSymlinked(filePath: string): Promise<boolean> {
  try {
    const path = $.path(filePath);
    if (await path.exists()) {
      const stat = await path.lstat();
      return stat?.isSymlink || false;
    }
    return false;
  } catch {
    return false;
  }
}

// Test proto installation
Deno.test("Proto is installed", async () => {
  assert(await commandExists("proto"), "proto command should be available");
});

// Test Deno installation
Deno.test("Deno is installed", async () => {
  assert(await commandExists("deno"), "deno command should be available");
});

// Test configuration files
Deno.test("Git config exists", async () => {
  assert(
    await homeDir.join(".gitconfig").exists(),
    "Git config file should exist",
  );
});

Deno.test("Fish config exists", async () => {
  assert(
    await homeDir.join(".config/fish/config.fish").exists(),
    "Fish config file should exist",
  );
});

Deno.test("Neovim config exists", async () => {
  assert(
    await homeDir.join(".config/nvim/init.lua").exists(),
    "Neovim config file should exist",
  );
});

Deno.test("Tmux config exists", async () => {
  assert(
    await homeDir.join(".tmux.conf").exists(),
    "Tmux config file should exist",
  );
});

Deno.test("Zsh config exists", async () => {
  assert(await homeDir.join(".zshrc").exists(), "Zsh config file should exist");
});

// Test installed tools
Deno.test("Git is installed", async () => {
  assert(await commandExists("git"), "git command should be available");
});

Deno.test("Docker is installed", async () => {
  assert(await commandExists("docker"), "docker command should be available");
});

Deno.test("GitHub CLI is installed", async () => {
  assert(await commandExists("gh"), "gh command should be available");
});

Deno.test("Neovim is installed", async () => {
  assert(await commandExists("nvim"), "nvim command should be available");
});

Deno.test("Tmux is installed", async () => {
  try {
    await $`tmux -V`;
    assert(true);
  } catch {
    assert(false, "tmux command should be available");
  }
});

Deno.test("Ripgrep is installed", async () => {
  assert(await commandExists("rg"), "rg command should be available");
});

Deno.test("fzf is installed", async () => {
  assert(await commandExists("fzf"), "fzf command should be available");
});

// Test symlinks
Deno.test("Git config is symlinked", async () => {
  const gitConfigPath = homeDir.join(".gitconfig").toString();
  assert(await isSymlinked(gitConfigPath), "Git config should be symlinked");
});

Deno.test("Fish config is symlinked", async () => {
  const fishConfigPath = homeDir.join(".config/fish/config.fish").toString();
  assert(await isSymlinked(fishConfigPath), "Fish config should be symlinked");
});

// Test language installations
Deno.test("Ruby (rbenv) is available", async () => {
  assert(await commandExists("rbenv"), "rbenv command should be available");
});

Deno.test("Rust is installed", async () => {
  assert(await commandExists("rustc"), "rustc command should be available");
});

Deno.test("Go is installed", async () => {
  try {
    await $`go version`;
    assert(true);
  } catch {
    assert(false, "go command should be available");
  }
});
