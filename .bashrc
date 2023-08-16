# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
source /opt/rh/devtoolset-7/enable
LANG="zh_CN.UTF-8"

# User specific aliases and functions

alias vi='vim'
alias tmux='tmux -2'

if [ "$TERM" == "xterm"  ]; then
    export TERM=xterm-256color
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

HOME_DIR=$(echo ~)
export PATH="$PATH:$HOME_DIR/work/github/yx-ren/scripts"

#source ls_color.sh
LS_COLORS=$LS_COLORS:'di=33;1'

ulimit -c unlimited
