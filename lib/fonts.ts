import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

const homeDir = $.path(Deno.env.get("HOME")!);
const repoDir = homeDir.join(".nerd-fonts");

console.log("🔤 Installing Nerd Fonts...");

if (await repoDir.exists()) {
  console.log("📁 Nerd Fonts repository already exists, skipping installation");
  Deno.exit(0);
}

console.log("📥 Cloning Nerd Fonts repository...");
try {
  // Try SSH first
  await $`git clone git@github.com:ryanoasis/nerd-fonts.git ${repoDir}`;
} catch {
  // Fallback to HTTPS if SSH fails
  console.log("🔄 SSH clone failed, trying HTTPS...");
  await $`git clone https://github.com/ryanoasis/nerd-fonts.git ${repoDir}`;
}

console.log("🔧 Installing Hack Nerd Font...");
await $`bash ${repoDir}/install.sh Hack`;

console.log("✅ Nerd Fonts installation completed!");
