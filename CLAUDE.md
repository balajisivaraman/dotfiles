# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A [chezmoi](https://chezmoi.io) dotfiles repository managing personal (macOS) and work (Linux) machine configurations.

## Key chezmoi Conventions

**File naming** — chezmoi maps source names to target paths:
- `dot_` prefix → leading `.` (e.g., `dot_gitconfig` → `~/.gitconfig`)
- `private_dot_config/` → `~/.config/` with restricted permissions (dir 700, file 600)
- `.tmpl` extension → file is a Go template, processed before being written to disk

**Platform split** — `darwin` is the personal macOS machine; `linux` is the work machine. Templates use `{{ .chezmoi.os }}` to branch between them.

## Common Commands

```sh
chezmoi apply          # write managed files to the home directory
chezmoi diff           # preview changes that would be applied
chezmoi edit <file>    # edit a source file (opens in $EDITOR)
chezmoi add <file>     # start managing a new home-directory file
chezmoi update         # pull latest changes from this repo and apply
```

When editing templates directly (`.tmpl` files), changes only take effect after `chezmoi apply`.

## Architecture

| Source file | Target | Notes |
|---|---|---|
| `dot_Brewfile.tmpl` | `~/.Brewfile` | Includes `.Brewfile.personal` on macOS, `.Brewfile.work` on Linux |
| `.Brewfile.personal` | (included by template) | macOS packages — Emacs, Claude Code, colima, fonts |
| `.Brewfile.work` | (included by template) | Linux packages — podman, awscli, glab |
| `dot_gitconfig` | `~/.gitconfig` | git-delta pager; Gruvbox Material Dark Hard colors |
| `dot_githelpers` | `~/.githelpers` | Shell functions used by git aliases (`pretty_git_log`) |
| `dot_tmux.conf` | `~/.tmux.conf` | TPM plugins; prefix is `C-Space`; sources tinty colors |
| `private_dot_config/tinted-theming/tinty/config.toml` | `~/.config/tinted-theming/tinty/config.toml` | Tinty theme manager; default `base16-gruvbox-material-dark-hard` |
| `private_dot_config/fish/config.fish.tmpl` | `~/.config/fish/config.fish` | Platform-branched Homebrew init; mise, starship, fzf, zoxide |
| `private_dot_config/mise/config.toml` | `~/.config/mise/config.toml` | Global tool versions (Node LTS, Python latest, Java 21, Go latest) |
| `private_dot_config/alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` | NotoSansM Nerd Font 14pt; imports tinty-generated colors.toml |


## Theme & Aesthetics

Theming is managed by **Tinty** (`private_dot_config/tinted-theming/tinty/config.toml`) using Base16 schemes. Default theme: `base16-gruvbox-material-dark-hard`. Running `tinty apply <theme>` distributes theme files to all configured apps.

Running `tinty apply <theme>` distributes theme files to all configured apps via hooks. Each app item:

- **tinted-shell**: modifies the terminal's 16 ANSI colors; bat uses these via `--theme="base16-256"`
- **tinted-terminal**: copies an alacritty colors file to `~/.config/alacritty/colors.toml`
- **tinted-fzf**: writes a fish file with `FZF_DEFAULT_OPTS` color flags to the tinty data dir
- **tinted-delta**: writes a gitconfig snippet included via `[include]` in `dot_gitconfig`
- **tinted-tmux**: copies a tmux colors file to `~/.config/tmux/colors.conf`; sourced by `dot_tmux.conf` on startup
- **tinted-claude-code**: writes `~/.claude/themes/tinty.json`; select once via `/theme → custom:tinty` in Claude Code

Hooks run under the default `sh` shell (no `shell =` override in config).

When adding new tool configs, check `github.com/tinted-theming` for an existing theme pack before hardcoding colors.

## Homebrew Bundle

`brew bundle` reads `~/.Brewfile`, which is generated from `dot_Brewfile.tmpl`. To install everything on a new machine: `brew bundle install --global`.
