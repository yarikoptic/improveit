# Subcommand Reference

## codespellit Subcommands

Run any subcommand with: `${CLAUDE_PLUGIN_ROOT}/codespellit <subcommand> [args]`

### `list [args]`

List typos found by codespell. Passes extra arguments to codespell. If codespell
finds typos, also shows a filtered view of ambiguous ones (lines containing commas
in the suggestion).

### `list-hits-sorted [args]`

Show typos sorted by frequency count. Useful for prioritizing which typos to fix
first. Output format: `count suggestion`.

### `fix-sorted <file>`

Apply fixes from a filtered list file. The file should contain lines with `==>`
(output from `list-hits-sorted` after manual filtering). Requires a clean git
working tree. Creates a commit with all fixes.

Workflow:
1. Run `list-hits-sorted > /tmp/fixes.txt`
2. Edit the file to keep only desired fixes
3. Run `fix-sorted /tmp/fixes.txt`

### `deduce-config`

Print the path to the codespell configuration file. Checks in order:
`.codespellrc`, `pyproject.toml` (for `[tool.codespell]`), `setup.cfg` (for
`[codespell]`).

### `add-precommit [config]`

Add codespell to `.pre-commit-config.yaml`. If the file exists, appends a
codespell entry with the current codespell version. If `config` is `pyproject.toml`,
adds `tomli` as an additional dependency. Commits the change.

### `datalad-run-w`

Auto-fix all typos via `datalad run -m "..." 'codespell -w'`. Creates a tracked
commit through datalad.

### `datalad-run-w-i`

Interactive typo fixing via `datalad run -m "..." codespell -w -i 3 -C 2`.
Prompts for each ambiguous typo with context. Requires user interaction.

### `send-pr`

Push the current branch to a fork remote and create a pull request on GitHub.
Sets up a fork remote if needed (using `gh repo fork`).

### `detect-platform`

Print the detected hosting platform: `github`, `codeberg`, `forgejo`, or
`unknown`. Detection is based on the origin remote URL.

### `setup-fork-remote`

Set up a fork remote for pushing. On GitHub, forks the repo via `gh` and adds
a `gh-{username}` remote. Returns the remote name.

### `clone <url>`

Clone a repository with `--filter=blob:none` (partial clone) and enter the
directory. Used as a convenience for starting work on a new repo.

## shellcheckit Subcommands

Run any subcommand with: `${CLAUDE_PLUGIN_ROOT}/shellcheckit <subcommand> [args]`

### `list [args]`

List all shell scripts detected in the repository. Detection uses shebang
patterns matching sh, bash, dash, and ksh interpreters. Excludes `.txt` and
`.md` files.

### `doit [args]`

Run shellcheck on all detected shell scripts. Passes extra arguments to
shellcheck.

### `autopatch [args]`

Apply automatic shellcheck fixes. Runs `shellcheck -f diff` on all detected
scripts and applies the resulting patch.

### `generate_workflow`

Generate `.github/workflows/shellcheck.yml` without creating a branch or
committing. If the workflow already exists, preserves the existing branch
configuration.
