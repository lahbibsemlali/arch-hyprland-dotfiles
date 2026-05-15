# Modular zsh config
ZSH_CONFIG_DIR="$HOME/.config/zsh"

if [[ -d "$ZSH_CONFIG_DIR" ]]; then
  source "$ZSH_CONFIG_DIR/exports.zsh"
  source "$ZSH_CONFIG_DIR/options.zsh"
  source "$ZSH_CONFIG_DIR/aliases.zsh"
  source "$ZSH_CONFIG_DIR/plugins.zsh"
fi

# Run fastfetch if interactive
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# pnpm
export PNPM_HOME="/home/lahbib/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
