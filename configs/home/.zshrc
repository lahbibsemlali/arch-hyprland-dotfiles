# Minimal zsh setup

export EDITOR="nvim"

# Better defaults
setopt autocd
setopt hist_ignore_dups
setopt share_history
bindkey -e

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

# Prompt
autoload -Uz colors vcs_info && colors
setopt prompt_subst

zstyle ':vcs_info:git:*' formats ' %F{yellow}git:(%b)%f'
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
}

PROMPT=$'%F{blue}%~%f${vcs_info_msg_0_} %F{green}>%f '

# Aliases
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias lt='eza -T --level=2 --icons'
alias cat='bat --style=plain'
alias grep='rg'

# Tools
# Use zoxide as cd replacement.
eval "$(zoxide init zsh --cmd cd)"

if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
