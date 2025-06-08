# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

improveit is a collection of shell script utilities for automating code quality tool setup in GitHub projects. The scripts help developers quickly add codespell (spell checking) and shellcheck (shell script linting) to their projects, including GitHub Actions workflows and pre-commit hooks.

## Key Scripts

- **codespellit**: Sets up codespell with workflow, config, and automatic typo fixing
- **shellcheckit**: Sets up shellcheck with workflow and automatic issue fixing
- **prit**: Helper for submitting pull requests.
- **common.sh**: Shared functionality for git operations and GitHub integration

## Development Commands

### Testing Scripts

Since these are shell scripts, test them by running directly:

```bash
# Test codespellit functionality
./codespellit list              # List typos in current repo
./codespellit fix-sorted        # Apply fixes interactively
./codespellit add-precommit     # Add pre-commit configuration

# Test shellcheckit functionality
./shellcheckit list             # List shell scripts
./shellcheckit doit             # Run shellcheck
./shellcheckit autopatch        # Apply automatic fixes
```

### Linting

Run shellcheck on the project's own scripts:
```bash
shellcheck codespellit shellcheckit prit common.sh
```

## Architecture Notes

1. **Branch Strategy**: Scripts create feature branches (`enh-codespell`, `enh-shellcheck`) for changes

2. **Configuration Detection**: Scripts check for existing configs before creating:
   - codespell: `.codespellrc`, `pyproject.toml`, `setup.cfg`
   - Avoids duplicate workflows in `.github/workflows/`

3. **GitHub Integration**: Requires `gh` CLI and git config:
   - `github.user`: GitHub username for fork remotes
   - `hub.oauthtoken`: Fallback auth token if GITHUB_TOKEN not set

4. **Workflow Pattern**: All scripts follow: detect → configure → commit → push → PR

## Important Implementation Details

- Scripts use `set -eu` for error handling
- GitHub Actions workflows use read-only permissions by default
- Pre-commit configs are validated with `yq` after modification
- Shell script detection uses shebang patterns, not just file extensions
- The `autopatch` feature in shellcheckit uses shellcheck's diff output format
