#!/usr/bin/env node

import { spawnSync } from "node:child_process";
import { createRequire } from "node:module";
import { dirname, resolve } from "node:path";

const installArgs = [
  "add",
  "noeljabraham/The-Effective-Prompt",
  "--skill",
  "effective-prompt-quick",
  "effective-prompt-interactive",
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

const removeLegacyArgs = [
  "remove",
  "effective-prompt",
  "--global",
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
  console.log(`skills ${removeLegacyArgs.join(" ")}`);
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

if (result.status !== 0) {
  process.exit(result.status ?? 1);
}

const cleanup = spawnSync(process.execPath, [skillsCli, ...removeLegacyArgs], {
  stdio: "inherit"
});

if (cleanup.error) {
  console.error(`Could not remove the legacy skill: ${cleanup.error.message}`);
  process.exit(1);
}

process.exit(cleanup.status ?? 1);
