import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

console.log("🔄 Updating package repositories...");
await $`sudo apt update`;

console.log("🔧 Installing development languages and tools...");

// Ruby (rbenv)
await $`sudo apt-get install -y rbenv`;

// Python (pyenv)
await $`curl https://pyenv.run | bash`;

// Rust
await $`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y`;

// Go
await $`sudo apt-get install -y golang-go`;

console.log("🛠️ Installing essential tools...");

// Git
await $`sudo apt-get install -y git`;

// Docker
await $`sudo apt-get install -y ca-certificates gnupg`;
await $`sudo install -m 0755 -d /etc/apt/keyrings`;
await $`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`;
await $`sudo chmod a+r /etc/apt/keyrings/docker.gpg`;

const arch = await $`dpkg --print-architecture`.text();
const versionCodename = await $`. /etc/os-release && echo "$VERSION_CODENAME"`.text();

await $`echo "deb [arch=${arch.trim()} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${versionCodename.trim()} stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`;
await $`sudo apt-get update`;
await $`sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`;
await $`sudo chmod 666 /var/run/docker.sock`;

// GitHub CLI
await $`type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)`;
await $`curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg`;
await $`sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg`;
await $`echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null`;
await $`sudo apt update`;
await $`sudo apt install gh -y`;

// Additional tools
const tools = [
  "docker-compose",
  "neovim",
  "xclip",
  "tmux", 
  "peco",
  "xdotool",
  "compiz",
  "fzf",
  "ripgrep"
];

for (const tool of tools) {
  console.log(`📥 Installing ${tool}...`);
  await $`sudo apt-get install -y ${tool}`;
}

// Install Go tools
console.log("🔧 Installing Go tools...");
await $`go install github.com/x-motemen/ghq@latest`;

// Install Node.js tools (assuming Node.js is installed via proto)
console.log("📦 Installing Node.js tools...");
try {
  await $`sudo npm i -g @antfu/ni`;
} catch (error) {
  console.log("⚠️ Skipping npm tools installation (npm not found)");
}

console.log("✅ Preinstall completed!");
