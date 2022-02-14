#!/bin/bash

go()
{
    PWD=`pwd`
    rm -rf ~/.emacs
    rm -rf ~/.emacs.d
    ln -s $PWD/.emacs.d ~
    echo "Installed."
}

if [ -a ~/.emacs -o -a ~/.emacs.d ]; then
    read -p "Overwrite existing emacs dot files? " response
    case $response in
        [Yy]*)
            go;;
        *)
            echo "Aborted."
            exit;;
    esac
else
    go
fi
