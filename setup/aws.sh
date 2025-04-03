#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Install AWS CLI?" --title "AWS CLI" $BOX_HEIGHT $BOX_WIDTH); then
    curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
fi
