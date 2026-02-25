set -g fish_greeting

set -gx EDITOR nvim

fish_add_path "$HOME/go/bin"

if test (uname) = Darwin
    set -gx PNPM_HOME "$HOME/Library/pnpm"
else
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end
fish_add_path "$PNPM_HOME"

if status is-interactive
    if test (uname) = Darwin
        alias ls='ls -G'
    else
        alias ls='ls --color=auto'
    end

    alias grep='grep --color=auto'
    alias n='nvim'
    alias y='yazi'
    alias gaa='git add .'
    alias gc='git commit'
    alias gca='git commit -a'
    alias gp='git pull'
    alias gpu='git push -u origin'
    alias gs='git status'
    alias gsw='git switch'
    alias gf='git fetch'
    alias gm='git merge'

    alias vpn-ax='sudo openvpn --config ~/.vpn/ax.ovpn'
    alias vpn-local='sudo openvpn --config ~/.vpn/local.ovpn'

    fnm env --use-on-cd --shell fish | source
    starship init fish | source

    if test (uname) = Darwin
        /opt/homebrew/bin/brew shellenv | source
    end

    if command -q fastfetch
        fastfetch
    end
end
