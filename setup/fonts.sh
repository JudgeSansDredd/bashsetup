#!/usr/bin/env bash

# Not currently being used - running `brew install font-hack-nerd-font` instead
source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Install fonts for terminal?" --title "fonts" $BOX_HEIGHT $BOX_WIDTH); then
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi
