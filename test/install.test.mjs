import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import test from "node:test";

test("installs effective-prompt for the four supported agent targets", () => {
  const output = execFileSync(process.execPath, ["bin/install.mjs", "--print-command"], {
    encoding: "utf8"
  });

  assert.match(output, /--skill effective-prompt/);
  for (const agent of ["claude-code", "codex", "antigravity", "antigravity-cli"]) {
    assert.match(output, new RegExp(`--agent ${agent}(?:\\s|$)`));
  }
});
