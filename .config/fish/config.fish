function fish_greeting
end

set -Ux EDITOR helix

# Aliases for commonly used commands
# ------------------

alias ls="exa --long --no-user --icons --group-directories-first"
alias copy="xclip -selection clipboard"
alias cdd="cd ~/Dev"
alias shx="sudo hx"
alias lg="lazygit"

# Shell integration
# ------------------
if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

zoxide init --cmd cd fish | source
atuin init fish --disable-up-arrow | source

starship init fish | source
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
