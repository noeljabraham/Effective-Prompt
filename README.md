# Effective Prompt

Turn rough prompts into clear, agent-ready prompts.

```bash
npx effective-prompt@latest
```

![Effective Prompt demo](https://raw.githubusercontent.com/noeljabraham/The-Effective-Prompt/main/assets/demo.gif)

`effective-prompt` preserves your intent, finds missing requirements and contradictions, and returns a clearer prompt for Claude Code, Codex, and Google Antigravity.

## Before and after

### Coding

**Before:** `Fix the login bug.`

**After:**

> Reproduce and diagnose the login failure before changing code. Fix the root cause while preserving existing behavior, add a regression test, run the relevant checks, and summarize the cause and solution. If reproduction details or logs are missing, ask for them first.

### Writing

**Before:** `Write a launch email.`

**After:**

> Write a concise product-launch email for existing customers. Use a confident, friendly tone and include a subject line, the primary customer benefit, and one clear call to action. Use only the product facts provided and identify any essential information that is still missing.

### Research

**Before:** `Compare Notion and Obsidian.`

**After:**

> Compare Notion and Obsidian for an individual building a long-term personal knowledge base. Evaluate offline access, data ownership, linking, extensibility, collaboration, learning curve, and current pricing using authoritative sources. Finish with a recommendation and explain which user profile should choose each product.

### Business

**Before:** `Make a marketing plan for my app.`

**After:**

> Create a practical 90-day marketing plan for my app using the product, audience, budget, and traction details I provide. Prioritize channels by expected impact and effort, define weekly actions and measurable success metrics, and separate assumptions from known facts. Ask for any missing information that would materially change the plan.

## Install

Install the latest version globally with one command:

```bash
npx effective-prompt@latest
```

No repository clone or GitHub URL is required. The installer adds the skill to:

- Claude Code
- OpenAI Codex
- Google Antigravity
- Google Antigravity CLI

Requires Node.js 22.20 or later.

After installation, start a new agent session. In Antigravity CLI, you can instead run:

```text
/skills reload
```

## Use

### Claude Code and Antigravity

Quick mode improves the prompt immediately:

```text
/effective-prompt Write an email announcing our new product.
```

Interactive mode asks focused questions before rewriting it:

```text
/effective-prompt interactive Write an email announcing our new product.
```

### Codex

Use the Codex skill mention syntax:

```text
$effective-prompt Write an email announcing our new product.
```

For interactive mode:

```text
$effective-prompt interactive Write an email announcing our new product.
```

You can also invoke the skill without including a draft. It will improve the most recent user-authored prompt candidate in the conversation. Passing the draft with the command is more reliable because the agent cannot act on it before improving it.

## Modes

- **Quick**: audits silently and returns a ready-to-copy prompt.
- **Interactive**: asks only questions whose answers would materially change the prompt, then returns the final version.

The skill checks relevant details such as the intended outcome, context, inputs, deliverable, audience, constraints, acceptance criteria, ambiguities, tools, and safety concerns. It avoids inventing requirements or making a good prompt unnecessarily longer.

## Verify the installation

```bash
npx skills list --global --agent claude-code --agent codex --agent antigravity --agent antigravity-cli
```

The output should include `effective-prompt`.

## Uninstall

```bash
npx skills remove effective-prompt --global --agent '*' --yes
```

## Alternative GitHub installation

If npm is unavailable, install directly from GitHub:

```bash
npx skills add noeljabraham/The-Effective-Prompt --skill effective-prompt --global --copy --yes --agent claude-code --agent codex --agent antigravity --agent antigravity-cli
```

## Development

```bash
npm install
npm test
```

The portable skill source is [`skills/effective-prompt/SKILL.md`](skills/effective-prompt/SKILL.md).
