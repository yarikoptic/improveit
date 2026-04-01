---
name: improveit
description: >
  This skill should be used when the user asks to "add codespell", "add spell checking",
  "set up codespell", "add shellcheck", "set up shellcheck", "add linting",
  "improve code quality", "add code quality tools", or mentions "improveit".
  Adds codespell (spell checking) and/or shellcheck (shell linting) to projects
  with GitHub Actions workflows, configs, pre-commit hooks, automatic fixing, and PRs.
---

# improveit

Add codespell and/or shellcheck support to any Git project. This skill orchestrates
battle-tested shell scripts that handle the full workflow: detect project structure,
create configuration files, add GitHub Actions workflows, set up pre-commit hooks,
automatically fix issues, and open a pull request.

## Prerequisites

Before running any improveit script, verify these tools are available:

- **codespell** — spell checker (`pip install codespell`)
- **shellcheck** — shell script linter (via package manager)
- **gh** — GitHub CLI, authenticated (`gh auth login`)
- **datalad** — data management tool (`pip install datalad`)
- **git** — with `github.user` configured (`git config --global github.user USERNAME`)

Check prerequisites by running:

```bash
command -v codespell && command -v shellcheck && command -v gh && command -v datalad && git config github.user
```

If any prerequisite is missing, inform the user and suggest how to install it before proceeding.

## Adding Codespell Support

To add codespell to the current project, run the full codespellit workflow:

```bash
${CLAUDE_PLUGIN_ROOT}/codespellit
```

This single command performs the entire workflow:

1. Creates a feature branch `enh-codespell`
2. Detects files to skip (PDFs, SVGs, lock files, etc.)
3. Creates codespell config (in `pyproject.toml`, `setup.cfg`, or `.codespellrc`)
4. Generates a GitHub Actions workflow (`.github/workflows/codespell.yml`)
5. Adds codespell to `.pre-commit-config.yaml` (if it exists)
6. Commits all configuration
7. Runs `codespell -w` via datalad to auto-fix typos
8. Runs interactive fixing for ambiguous typos (requires user input)
9. Pushes to a fork remote and opens a PR

**Important:** Step 8 (`datalad-run-w-i`) is interactive — it prompts for each ambiguous typo. The user must interact with this step. Inform the user before running the full workflow that it will require their input for ambiguous fixes.

**Important:** The script sources `common.sh` on startup, which automatically forks the upstream repo on GitHub and adds a remote. This is expected behavior.

To run individual steps instead of the full workflow, use subcommands. See `references/subcommands.md` for details.

## Adding Shellcheck Support

To add shellcheck to the current project, run:

```bash
${CLAUDE_PLUGIN_ROOT}/shellcheckit
```

This performs the workflow:

1. Detects shell scripts by scanning for shebangs (`#!/bin/bash`, `#!/usr/bin/env sh`, etc.)
2. If no shell scripts are found, exits with a message
3. Creates a feature branch `enh-shellcheck`
4. Generates a GitHub Actions workflow (`.github/workflows/shellcheck.yml`)
5. Adds shellcheck to `.pre-commit-config.yaml` (if it exists)
6. Runs shellcheck on all detected scripts and reports findings

Unlike codespellit, shellcheckit does **not** automatically push or create a PR. After running, review the shellcheck output with the user and help fix any issues. Then commit, push, and create a PR manually.

To apply automatic shellcheck fixes:

```bash
${CLAUDE_PLUGIN_ROOT}/shellcheckit autopatch
```

## Selective Operations

Both scripts support subcommands for running individual steps. Common patterns:

**List issues without fixing:**
```bash
${CLAUDE_PLUGIN_ROOT}/codespellit list          # List typos
${CLAUDE_PLUGIN_ROOT}/shellcheckit doit          # Run shellcheck
```

**Just add workflows/configs (no fixing):**
```bash
${CLAUDE_PLUGIN_ROOT}/shellcheckit generate_workflow
```

For the full subcommand reference, consult `references/subcommands.md`.

## Workflow Summary

When the user asks to "add codespell" or "add shellcheck" or both:

1. Confirm which tools to add (codespell, shellcheck, or both)
2. Verify prerequisites are installed
3. Run the appropriate script(s)
4. Monitor output and assist with any interactive prompts
5. Review the results with the user
6. For shellcheckit: help fix issues and create the PR manually

When adding both tools, run codespellit first, then shellcheckit, as they create separate branches.

## Additional Resources

### Reference Files

For detailed subcommand documentation:
- **`references/subcommands.md`** — Complete subcommand reference for both codespellit and shellcheckit
