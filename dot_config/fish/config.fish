set -g fish_greeting

set -gx EDITOR nvim

fish_add_path "$HOME/go/bin"

if test (uname) = Darwin
    set -gx PNPM_HOME "$HOME/Library/pnpm"
else
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end
fish_add_path "$PNPM_HOME"

set -gx ANDROID_SDK_ROOT $HOME/Android/Sdk
fish_add_path $ANDROID_SDK_ROOT/emulator
fish_add_path $ANDROID_SDK_ROOT/platform-tools
fish_add_path $HOME/.maestro/bin

if status is-interactive
    bind \cy forward-char

    abbr -a n 'nvim'
    abbr -a y 'yazi'
    abbr -a gaa 'git add .'
    abbr -a gc 'git commit'
    abbr -a gca 'git commit -a'
    abbr -a gp 'git pull'
    abbr -a gpu 'git push -u origin'
    abbr -a gs 'git status'
    abbr -a gsw 'git switch'
    abbr -a gf 'git fetch'
    abbr -a gm 'git merge'

    abbr -a vpn-ax 'sudo openvpn --config ~/.vpn/ax.ovpn'
    abbr -a vpn-local 'sudo openvpn --config ~/.vpn/local.ovpn'

    fnm env --use-on-cd --shell fish | source
    starship init fish | source

    if test (uname) = Darwin
        /opt/homebrew/bin/brew shellenv | source
    end

end
