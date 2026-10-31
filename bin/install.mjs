#!/usr/bin/env node

import { spawnSync } from "node:child_process";
import { createRequire } from "node:module";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const packageRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const installArgs = [
  "add",
  packageRoot,
  "--skill",
  "effective-prompt",
  "--global",
  "--copy",
  "--yes",
  "--agent",
  "claude-code",
  "--agent",
  "codex",
  "--agent",
  "antigravity",
  "--agent",
  "antigravity-cli"
];

if (process.argv.includes("--print-command")) {
  console.log(`skills ${installArgs.join(" ")}`);
  process.exit(0);
}

const require = createRequire(import.meta.url);
const skillsCli = resolve(dirname(require.resolve("skills/package.json")), "bin/cli.mjs");
const result = spawnSync(process.execPath, [skillsCli, ...installArgs], {
  stdio: "inherit"
});

if (result.error) {
  console.error(`Could not start the skills installer: ${result.error.message}`);
  process.exit(1);
}

process.exit(result.status ?? 1);
