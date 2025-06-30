#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

source $HOME/.bash/setup/brew_installable.sh

whiptail_brew_installable=()
for value in "${brew_installable[@]}"
do
    whiptail_brew_installable+=("$value" "" ON)
done
choices=($(whiptail --title "Brew Install" --separate-output --checklist "What brew installable apps would you like installed?" $BOX_HEIGHT $BOX_WIDTH 20 "${whiptail_brew_installable[@]}" 3>&2 2>&1 1>&3))
exitstatus=$?

if [ $exitstatus = 0 ]; then
    if [ ${#choices[@]} -gt 0 ]; then
        brew install "${choices[@]}"
        brew cleanup
        brew doctor
    fi
fi

# Setup starship options
if [[ " ${choices[*]} " =~ "starship" ]]; then
    if (whiptail --yesno "Link starship.toml to config directory?" --title ".zshrc" $BOX_HEIGHT $BOX_WIDTH); then
        ln -nsf $HOME/.bash/configs/starship.toml $HOME/.config/starship.toml
    fi
fi
