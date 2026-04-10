# Minimal zsh setup

export EDITOR="nvim"

# pipx and other user-local CLIs (~/.local/bin)
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# Better defaults
setopt autocd
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt extended_glob
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

# Completion (case-insensitive where useful, menu, colors)
autoload -Uz compinit
compinit -C

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
if [[ -n ${LS_COLORS:-} ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{cyan}%d%f'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}%d%f'

# pipx tab completions (needs: pacman -S python-argcomplete)
if command -v register-python-argcomplete >/dev/null 2>&1; then
  eval "$(register-python-argcomplete pipx)"
fi

# Ghost-style autosuggestions (dim; matches indigo terminal theme)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6f7aa3'

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

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax highlighting must load last
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
