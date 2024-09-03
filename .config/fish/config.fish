function fish_greeting
end

if status is-interactive
end

set -Ux EDITOR helix

# Aliases for commonly used commands
# ------------------

alias ls="exa --long --no-user --icons --group-directories-first"
alias copy="xclip -selection clipboard"
alias cdd="cd ~/Dev"
alias shx="sudo hx"
alias bnd="bun run dev"
alias bnb="bun run build"
alias bnp="bun run preview"
alias lg="lazygit"

# Shell integration
# ------------------

# mise activate fish | source
zoxide init --cmd cd fish | source
atuin init fish --disable-up-arrow | source

starship init fish | source
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
