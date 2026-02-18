# ============================================================================
# Fish Shell Configuration - 2026 Fresh Start
# ============================================================================

# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------
set -gx EDITOR vim

# ----------------------------------------------------------------------------
# Homebrew Setup
# ----------------------------------------------------------------------------
set -gx HOMEBREW_BUNDLE_FILE ~/.Brewfile
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
/opt/homebrew/bin/brew shellenv | source
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# ----------------------------------------------------------------------------
# Path
# ----------------------------------------------------------------------------
fish_add_path $HOME/.local/bin

# ----------------------------------------------------------------------------
# Version Management (mise)
# ----------------------------------------------------------------------------
mise activate fish | source

# ----------------------------------------------------------------------------
# Starship Prompt
# ----------------------------------------------------------------------------
starship init fish | source

# ----------------------------------------------------------------------------
# FZF (with Dracula theme)
# ----------------------------------------------------------------------------
fzf --fish | source

set -gx FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# ----------------------------------------------------------------------------
# zoxide (smarter cd)
# ----------------------------------------------------------------------------
zoxide init fish | source

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------
alias l="eza -la --sort=modified --reverse --git-ignore"
alias v="vim"
alias vim="vim"
alias tmux="tmux -u"
