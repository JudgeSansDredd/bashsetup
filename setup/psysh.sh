#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Install psysh (php shell)?" --title "Psysh" $BOX_HEIGHT $BOX_WIDTH); then
    composer global require psy/psysh
fi
