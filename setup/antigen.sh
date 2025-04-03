#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Install Antigen?" --title "Antigen" $BOX_HEIGHT $BOX_WIDTH); then
    curl -L git.io/antigen > $HOME/antigen.zsh
fi
