# Custom history functions
save_history() { builtin history -a &>/dev/null }
load_history() { builtin history -n &>/dev/null }

# NVM loading (if you're not using programs.nvm module)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Source secrets (can be kept here or remain in initExtra if preferred)
if [ -f "$HOME/.zshrc_secrets" ]; then
  . "$HOME/.zshrc_secrets"
fi

# My custom stow function
mystow() {
  stow --target="$HOME" -Rv "$@" 2>&1 | grep -vE "BUG in find_stowed_path|/nix/store"
}

# Change cursor shape
printf '\e[5 q'

# Other Zsh-specific configurations or aliases
# alias ll='ls -lha'
