if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (zellij setup --generate-auto-start fish | string collect)
end

function fish_greeting
    # echo "Greetings, it's $(set_color yellow; date; set_color normal) on Earth"
end

set EDITOR micro

alias ls="exa --icons --group-directories-first"
alias e="$EDITOR"
alias cdd="cd ~/Dev"
alias hx="helix"
alias gg="lazygit"

zoxide init --cmd cd fish | source
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/hammad/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
mise activate fish | source
