#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Link .zshrc to home directory?" --title ".zshrc" $BOX_HEIGHT $BOX_WIDTH); then
    ln -sf $HOME/.bash/configs/.zshrc $HOME/.zshrc
fi
