# Effective Prompt

`effective-prompt` is a portable [Agent Skill](https://agentskills.io) that rewrites a draft prompt without changing its intent.

It has two modes:

- **Quick** (default): silently audits the draft, fixes the important gaps, and returns a ready-to-use prompt.
- **Interactive**: asks only the questions whose answers would materially change the prompt, then returns the final version.

## Use it

Claude Code and Google Antigravity expose installed skills as slash commands:

```text
/effective-prompt Write a launch email for our new product.
/effective-prompt interactive Write a launch email for our new product.
```

In Codex, invoke the skill as `$effective-prompt` and include `interactive` when you want the interview mode. Natural-language invocation also works on compatible agents.

If you invoke the skill without a draft, it uses the most recent user-authored prompt candidate in the conversation. Passing the draft with the command is more reliable because it prevents the agent from acting on the draft before improving it.

## Install with one command

The project uses the standard [`skills`](https://skills.sh) installer, so it does not need its own npm package.

From this repository, install it globally for Claude Code, Codex, Antigravity, and Antigravity CLI:

```bash
npx skills add . --skill effective-prompt --global --copy --yes --agent claude-code --agent codex --agent antigravity --agent antigravity-cli
```

After this repository is public on GitHub, replace `.` with its GitHub shorthand:

```bash
npx skills add YOUR_GITHUB_USERNAME/the-effective-prompt --skill effective-prompt --global --copy --yes --agent claude-code --agent codex --agent antigravity --agent antigravity-cli
```

Use this only if you intentionally want the skill installed for every agent supported by the installer, not just those four:

```bash
npx skills add YOUR_GITHUB_USERNAME/the-effective-prompt --skill effective-prompt --global --copy --yes --agent '*'
```

The installer requires Node.js 22.20 or later. `--copy` is used for reliable Antigravity discovery; copied installations can be refreshed with:

```bash
npx skills update effective-prompt --global --yes
```

## Install manually

Copy `skills/effective-prompt` into the directory used by your agent:

| Agent | Personal/global location | Project location |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/effective-prompt` | `.claude/skills/effective-prompt` |
| Codex | `~/.codex/skills/effective-prompt` | `.agents/skills/effective-prompt` |
| Antigravity App/IDE | `~/.gemini/config/skills/effective-prompt` | `.agents/skills/effective-prompt` |
| Antigravity CLI | `~/.gemini/antigravity-cli/skills/effective-prompt` | `.agents/skills/effective-prompt` |

After installing in Antigravity CLI, start a new conversation or run `/skills reload`.

## Publish it

The simplest marketplace is [skills.sh](https://skills.sh):

1. Create a public GitHub repository and push this project.
2. Verify discovery with `npx skills add YOUR_GITHUB_USERNAME/the-effective-prompt --list`.
3. Share the one-command installer above. Public GitHub skills become eligible for skills.sh discovery through installer usage.

Claude and Antigravity also have plugin marketplaces, but they require vendor-specific manifests, publisher metadata, branding, validation, and marketplace submission. Add those only when the author name, license, repository URL, and logo are final. The standalone `npx skills` installation preserves the short `/effective-prompt` command in Claude and Antigravity; a Claude plugin would namespace it as `/plugin-name:effective-prompt`.

Keep `skills/effective-prompt/SKILL.md` as the single source of behavior. Package that folder using each marketplace's plugin manifest and submission process; do not fork the instructions per vendor unless a platform requires a launcher-specific adapter.

Before publishing, test the skill against a small evaluation set: a vague request, a strong prompt that needs almost no editing, a prompt with conflicting constraints, a prompt requiring current information, and an interactive request with one genuinely blocking ambiguity.

