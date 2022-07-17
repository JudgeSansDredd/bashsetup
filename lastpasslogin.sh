TERMINAL_HEIGHT=`tput lines`
BOX_HEIGHT=`printf "%.0f" $(echo "scale=2; $TERMINAL_HEIGHT * .5" | bc)`
TERMINAL_WIDTH=`tput cols`
BOX_WIDTH=`printf "%.0f" $(echo "scale=2; $TERMINAL_WIDTH * .75" | bc)`

LASTPASS_DIRECTORY="$HOME/.lpass"
CONFIG_FILE="$LASTPASS_DIRECTORY/config"

mkdir -p $LASTPASS_DIRECTORY

source $CONFIG_FILE

# Ensure you have whiptail and lastpass installed
if hash whiptail 2>/dev/null; then
    echo ""
else
    if [ "$(uname)" = "Darwin" ]; then
        brew install newt
    elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        sudo apt install whiptail
    fi
fi
if hash lpass 2>/dev/null; then
    echo ""
else
    if (whiptail --yesno "You must install LastPass CLI to use this tool. Do you with to continue?" $BOX_HEIGHT $BOX_WIDTH); then
        if [ "$(uname)" = "Darwin" ]; then
            brew install lastpass-cli
        elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
            sudo apt install lastpass-cli
        fi
    fi
fi

_ensure_lpass

if [ -z "$LASTPASS_EMAIL" ]; then
    LASTPASS_EMAIL=$(whiptail --inputbox "LastPass Account Email" --nocancel $BOX_HEIGHT $BOX_WIDTH $LASTPASS_EMAIL --title "LastPass Email" 3>&1 1>&2 2>&3)
fi

if [ -z "$LASTPASS_SSH_CONFIG_DIRECTORY" ]; then
    LASTPASS_SSH_CONFIG_DIRECTORY=$(whiptail --inputbox "Where (in Lastpass) do you keep your ssh configs?" --nocancel $BOX_HEIGHT $BOX_WIDTH $LASTPASS_EMAIL --title "LastPass SSH Config Directory" 3>&1 1>&2 2>&3)
fi