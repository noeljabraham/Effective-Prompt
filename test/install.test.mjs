import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import test from "node:test";

test("installs both effective-prompt modes for the four supported agent targets", () => {
  const output = execFileSync(process.execPath, ["bin/install.mjs", "--print-command"], {
    encoding: "utf8"
  });

  assert.match(output, /skills add noeljabraham\/The-Effective-Prompt/);
  assert.match(output, /--skill effective-prompt-quick effective-prompt-interactive/);
  assert.match(output, /skills remove effective-prompt --global --yes/);
  for (const agent of ["claude-code", "codex", "antigravity", "antigravity-cli"]) {
    assert.match(output, new RegExp(`--agent ${agent}(?:\\s|$)`));
  }
});
