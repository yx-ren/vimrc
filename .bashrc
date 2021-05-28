alias rm='rm -i'
alias mv='mv -i'

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ctex='ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extras=+q --language-force=C++ -o .tags'

HOME_DIR=$(echo ~)
export PATH="$PATH:$HOME_DIR/work/github/yx-ren/scripts"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi
