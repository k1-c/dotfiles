import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

const projectRoot = $.path(import.meta.url).parent()!.parent()!;
const extensionSourcePath = projectRoot.join("config/vscode/User/extensions");

console.log("💻 Installing VSCode extensions...");

try {
  // Check if VSCode is installed
  await $`code --version`;

  // Read extension list
  const extensionList = await extensionSourcePath.readText();
  const extensions = extensionList.trim().split("\n").filter((line) =>
    line.trim() !== ""
  );

  // Install each extension
  for (const extension of extensions) {
    if (extension.trim()) {
      console.log(`📦 Installing extension: ${extension}`);
      try {
        await $`code --install-extension ${extension}`;
      } catch (error) {
        console.log(`⚠️ Failed to install extension: ${extension}`);
        console.error(error);
      }
    }
  }

  console.log("📋 Updating extension list...");
  // Export currently installed extensions back to the file
  const installedExtensions = await $`code --list-extensions`.text();
  await extensionSourcePath.writeText(installedExtensions);

  console.log("✅ VSCode extensions setup completed!");
} catch (_error) {
  console.log("⚠️ VSCode not found, skipping extension installation");
  console.log("To install VSCode extensions later, run: deno task vscode");
}
