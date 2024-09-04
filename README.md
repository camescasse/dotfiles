To copy settings on a new machine:

Define alias:
```alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'```

Clone:
```git clone --bare https://github.com/camescasse/dotfiles.git $HOME/.dotfiles```

Define git config:
```dotfiles config --local status.showUntrackedFiles no```

Checkout:
```dotfiles checkout```

If any of the files already exist, you will see an error. Remove the collisions and repeat the checkout step.
