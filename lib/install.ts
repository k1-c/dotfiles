import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

const projectRoot = $.path(import.meta.url).parent()!.parent()!;

console.log("🚀 Starting dotfiles installation...");

// Run preinstall to install system dependencies
console.log("📦 Installing system dependencies...");
await $`deno run --allow-all ${projectRoot}/lib/preinstall.ts`;

// Configure symlinks
console.log("🔗 Creating configuration symlinks...");
await $`deno run --allow-all ${projectRoot}/lib/config.ts`;

// Install VSCode extensions
console.log("💻 Installing VSCode extensions...");
await $`deno run --allow-all ${projectRoot}/lib/vscode.ts`;

// Install Nerd Fonts
console.log("🔤 Installing Nerd Fonts...");
await $`deno run --allow-all ${projectRoot}/lib/fonts.ts`;

console.log("✅ Dotfiles installation completed successfully!");
