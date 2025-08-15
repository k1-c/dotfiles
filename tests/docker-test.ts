import $ from "https://deno.land/x/dax@0.39.2/mod.ts";

const testsDir = $.path(import.meta.url).parent()!;
const envDir = testsDir.join("environment");
const projectRoot = testsDir.parent()!;

interface TestCommand {
  name: string;
  description: string;
  command: string[];
}

const getTestCommands = (dockerComposeFile: string) => [
  {
    name: "full",
    description: "Run full dotfiles installation test",
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "dotfiles-test"]
  },
  {
    name: "preinstall",
    description: "Test system dependencies installation only",
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "test-preinstall"]
  },
  {
    name: "config",
    description: "Test configuration symlinks setup only", 
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "test-config"]
  },
  {
    name: "vscode",
    description: "Test VSCode extensions installation only",
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "test-vscode"]
  },
  {
    name: "fonts",
    description: "Test Nerd Fonts installation only",
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "test-fonts"]
  },
  {
    name: "interactive",
    description: "Start interactive container for manual testing",
    command: ["docker-compose", "-f", dockerComposeFile, "up", "--build", "dotfiles-dev"]
  }
];

function printInfo(message: string) {
  console.log(`🔵 [INFO] ${message}`);
}

function printSuccess(message: string) {
  console.log(`🟢 [SUCCESS] ${message}`);
}

function printError(message: string) {
  console.log(`🔴 [ERROR] ${message}`);
}

function printWarning(message: string) {
  console.log(`🟡 [WARN] ${message}`);
}

async function checkDockerAvailable(): Promise<boolean> {
  try {
    await $`docker --version`;
    await $`docker-compose --version`;
    return true;
  } catch {
    printError("Docker or docker-compose is not available");
    return false;
  }
}

async function buildDockerImage(): Promise<void> {
  printInfo("Building Docker test image...");
  const dockerComposeFile = envDir.join("docker-compose.yml").toString();
  await $`docker-compose -f ${dockerComposeFile} build dotfiles-test`;
  printSuccess("Docker image built successfully");
}

async function runTest(testName: string): Promise<void> {
  const dockerComposeFile = envDir.join("docker-compose.yml").toString();
  const testCommands = getTestCommands(dockerComposeFile);
  const test = testCommands.find(t => t.name === testName);
  if (!test) {
    printError(`Unknown test: ${testName}`);
    printAvailableTests();
    return;
  }

  printInfo(`Running test: ${test.description}`);
  try {
    await $`${test.command}`;
    printSuccess(`Test completed: ${testName}`);
  } catch (error) {
    printError(`Test failed: ${testName}`);
    throw error;
  }
}

async function validateInstallation(): Promise<void> {
  printInfo("Running validation tests in Docker container...");
  const dockerComposeFile = envDir.join("docker-compose.yml").toString();
  
  try {
    // Run full installation first
    await $`docker-compose -f ${dockerComposeFile} up --build --exit-code-from dotfiles-test dotfiles-test`;
    
    // Then run validation tests
    await $`docker-compose -f ${dockerComposeFile} run --rm dotfiles-test bash -c "export PATH=\"\\$HOME/.proto/bin:\\$PATH\" && deno test --allow-all tests/test.ts"`;
    
    printSuccess("Validation tests completed");
  } catch (error) {
    printError("Validation tests failed");
    throw error;
  }
}

async function cleanupDocker(): Promise<void> {
  printInfo("Cleaning up Docker resources...");
  const dockerComposeFile = envDir.join("docker-compose.yml").toString();
  try {
    await $`docker-compose -f ${dockerComposeFile} down --remove-orphans`;
    await $`docker system prune -f`;
    printSuccess("Docker cleanup completed");
  } catch (error) {
    printWarning("Some cleanup operations failed");
  }
}

function printAvailableTests(): void {
  console.log("\n📋 Available tests:");
  const dockerComposeFile = envDir.join("docker-compose.yml").toString();
  const testCommands = getTestCommands(dockerComposeFile);
  testCommands.forEach(test => {
    console.log(`  ${test.name.padEnd(12)} - ${test.description}`);
  });
}

function printHelp(): void {
  console.log("🐳 Dotfiles Docker Testing with Deno");
  console.log("");
  console.log("Usage: deno task test:docker [command]");
  console.log("");
  console.log("Commands:");
  console.log("  build       - Build Docker test image");
  console.log("  run [test]  - Run specific test (see available tests below)");
  console.log("  validate    - Run validation tests after installation");
  console.log("  cleanup     - Clean up Docker resources");
  console.log("  help        - Show this help message");
  console.log("");
  printAvailableTests();
  console.log("");
  console.log("Examples:");
  console.log("  deno task test:docker build");
  console.log("  deno task test:docker run full");
  console.log("  deno task test:docker run interactive");
  console.log("  deno task test:docker validate");
  console.log("  deno task test:docker cleanup");
}

async function main(): Promise<void> {
  const args = Deno.args;
  const command = args[0] || "help";
  
  // Check if Docker is available
  if (command !== "help" && !(await checkDockerAvailable())) {
    Deno.exit(1);
  }

  try {
    switch (command) {
      case "build":
        await buildDockerImage();
        break;
        
      case "run":
        const testName = args[1];
        if (!testName) {
          printError("Please specify a test to run");
          printAvailableTests();
          Deno.exit(1);
        }
        await runTest(testName);
        break;
        
      case "validate":
        await validateInstallation();
        break;
        
      case "cleanup":
        await cleanupDocker();
        break;
        
      case "help":
      default:
        printHelp();
        break;
    }
  } catch (error) {
    printError(`Command failed: ${error.message}`);
    Deno.exit(1);
  }
}

// Quick test functions for convenience
async function runQuickTest(testType: string): Promise<void> {
  if (!(await checkDockerAvailable())) {
    Deno.exit(1);
  }
  
  try {
    await runTest(testType);
  } catch (error) {
    printError(`Quick test failed: ${error.message}`);
    Deno.exit(1);
  }
}

// Export quick test functions
if (import.meta.main) {
  await main();
}

// Quick test exports for other scripts
export { runQuickTest, validateInstallation, cleanupDocker };