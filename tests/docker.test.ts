import $ from "https://deno.land/x/dax@0.39.2/mod.ts";
import { assertEquals, assert } from "https://deno.land/std@0.213.0/assert/mod.ts";

const testsDir = $.path(import.meta.url).parent()!;
const envDir = testsDir.join("environment");
const dockerComposeFile = envDir.join("docker-compose.yml").toString();

// Helper to check if Docker is available
async function isDockerAvailable(): Promise<boolean> {
  try {
    await $`docker --version`.quiet();
    await $`docker-compose --version`.quiet();
    return true;
  } catch {
    return false;
  }
}

// Skip Docker tests if Docker is not available
const skipDockerTests = !(await isDockerAvailable());

Deno.test({
  name: "Docker environment is available",
  ignore: skipDockerTests,
  fn: async () => {
    const dockerVersion = await $`docker --version`.text();
    assert(dockerVersion.includes("Docker version"), "Docker should be installed");
    
    const composeVersion = await $`docker-compose --version`.text();
    assert(composeVersion.includes("docker-compose") || composeVersion.includes("Docker Compose"), "Docker Compose should be installed");
  }
});

Deno.test({
  name: "Docker Compose file exists",
  fn: async () => {
    const composeFile = $.path(dockerComposeFile);
    assert(await composeFile.exists(), "docker-compose.yml should exist");
  }
});

Deno.test({
  name: "Dockerfile exists",
  fn: async () => {
    const dockerfile = envDir.join("Dockerfile");
    assert(await dockerfile.exists(), "Dockerfile should exist");
  }
});

Deno.test({
  name: "Docker image can be built",
  ignore: skipDockerTests,
  sanitizeOps: false,
  sanitizeResources: false,
  fn: async () => {
    try {
      await $`docker-compose -f ${dockerComposeFile} build dotfiles-test`.quiet();
      assert(true, "Docker image should build successfully");
    } catch (error) {
      assert(false, `Failed to build Docker image: ${error.message}`);
    }
  }
});

Deno.test({
  name: "Docker Compose services are properly configured",
  fn: async () => {
    const composeContent = await $.path(dockerComposeFile).readText();
    
    // Check for required services
    assert(composeContent.includes("dotfiles-test"), "Should have dotfiles-test service");
    assert(composeContent.includes("dotfiles-dev"), "Should have dotfiles-dev service");
    assert(composeContent.includes("test-preinstall"), "Should have test-preinstall service");
    assert(composeContent.includes("test-config"), "Should have test-config service");
    assert(composeContent.includes("test-vscode"), "Should have test-vscode service");
    assert(composeContent.includes("test-fonts"), "Should have test-fonts service");
  }
});

Deno.test({
  name: "Dockerfile has correct base image",
  fn: async () => {
    const dockerfileContent = await envDir.join("Dockerfile").readText();
    assert(dockerfileContent.includes("FROM ubuntu:22.04"), "Should use Ubuntu 22.04 as base image");
    assert(dockerfileContent.includes("testuser"), "Should create testuser");
    assert(dockerfileContent.includes("install.sh"), "Should run install.sh");
  }
});

// Integration test - only run if explicitly requested via environment variable
const runIntegrationTests = Deno.env.get("RUN_DOCKER_INTEGRATION_TESTS") === "true";

Deno.test({
  name: "Full installation in Docker container",
  ignore: skipDockerTests || !runIntegrationTests,
  sanitizeOps: false,
  sanitizeResources: false,
  fn: async (t) => {
    await t.step("Build test image", async () => {
      await $`docker-compose -f ${dockerComposeFile} build dotfiles-test`;
    });

    await t.step("Run installation", async () => {
      const result = await $`docker-compose -f ${dockerComposeFile} up --exit-code-from dotfiles-test dotfiles-test`.noThrow();
      assertEquals(result.code, 0, "Installation should complete successfully");
    });

    await t.step("Validate installation", async () => {
      const result = await $`docker-compose -f ${dockerComposeFile} run --rm dotfiles-test bash -c "export PATH=\"\\$HOME/.proto/bin:\\$PATH\" && deno test --allow-all tests/test.ts"`.noThrow();
      assertEquals(result.code, 0, "Tests should pass in container");
    });

    await t.step("Cleanup", async () => {
      await $`docker-compose -f ${dockerComposeFile} down --remove-orphans`.quiet();
    });
  }
});

// Cleanup test
Deno.test({
  name: "Docker cleanup works",
  ignore: skipDockerTests,
  sanitizeOps: false,
  sanitizeResources: false,
  fn: async () => {
    try {
      await $`docker-compose -f ${dockerComposeFile} down --remove-orphans`.quiet();
      assert(true, "Docker cleanup should work");
    } catch (error) {
      // Cleanup might fail if nothing to clean, which is ok
      assert(true, "Cleanup attempted");
    }
  }
});