#/bin/bash

HOME_DIR=$(echo ~)

BAK_POSTFIX=$(date +"%Y%m%d-%H%M%S")
BAK_DIR="/tmp/$BAK_POSTFIX.vimbak/"
mkdir $BAK_DIR
echo "create bak dir:[$BAK_DIR]"

BAK_FILES=("$HOME_DIR/.vimrc" "$HOME_DIR/.vim/")
for ((i = 0; i != ${#BAK_FILES[@]}; i++))
do
    BAK_SRC=${BAK_FILES[i]}
    if [ -d $BAK_SRC ] || [ -f $BAK_SRC ]; then
        echo "backup, move [$BAK_SRC] -> [$BAK_DIR]"
        mv "$BAK_SRC" "$BAK_DIR"
    fi
done

./copy_config.sh
