# Whiptail stuff - This is performed by `setup_whiptail`, but you may not have it yet
TERMINAL_HEIGHT=`tput lines`
BOX_HEIGHT=`printf "%.0f" $(echo "scale=2; $TERMINAL_HEIGHT * .5" | bc)`
TERMINAL_WIDTH=`tput cols`
BOX_WIDTH=`printf "%.0f" $(echo "scale=2; $TERMINAL_WIDTH * .75" | bc)`

if hash whiptail 2>/dev/null; then
    echo ""
else
    if [ "$(uname)" = "Darwin" ]; then
        brew install newt
    elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        sudo apt install whiptail
    fi
fi

source $HOME/.bash/brew/brew_installable.sh

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
