function fish_greeting
    # A tux greets you with random fortune
    # Packages: fortune-mod cowsay
    fortune | cowsay -f tux
end

if status is-interactive
end

# Enviroment variables
set -Ux EDITOR helix # package: helix

# Aliases for commonly used commands
# ---------------------------------- 
#
# If you want to use the default ls run `\ls`
# Package: exa
alias ls="exa --icons --group-directories-first"
#
# Package: lazygit
alias gg="lazygit"
#
# Package: zellij
alias zj="zellij"
#
# Best used when piping into this alias
# Package: xclip
alias copy="xclip -selection clipboard"
#
# Package: sl
alias claer=sl
#
alias cdd="cd ~/Dev"
alias hx="$EDITOR"
# bun aliases
alias bnd="bun run dev"
alias bnb="bun run build"
alias bnp="bun run preview"
#
# history grep alias
alias hg="history | grep"

# Shell integration 
# ------------------
#
# To use regular cd run it using `\cd`
# Package: zoxide 
zoxide init --cmd cd fish | source
#
# Package: starship
starship init fish | source
#
# Package: mise
mise activate fish | source

# pnpm
set -gx PNPM_HOME "/home/hammad/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Enable transient prompt for starship
# See: https://starship.rs/advanced-config/#transientprompt-and-transientrightprompt-in-fish
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
