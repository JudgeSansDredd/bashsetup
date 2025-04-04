#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Link .vimrc to this machine?" --title "Vimrc" $BOX_HEIGHT $BOX_WIDTH); then
    ln -nsf $HOME/.bash/configs/.vimrc $HOME/.vimrc
fi
