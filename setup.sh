#!/usr/bin/env bash
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

######################
# Setup Oh My Zshell #
######################

# Install homebrew
if (whiptail --yesno "Install Homebrew?" --title "Homebrew" $BOX_HEIGHT $BOX_WIDTH); then
    /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install antigen
if (whiptail --yesno "Install Antigen?" --title "Antigen" $BOX_HEIGHT $BOX_WIDTH); then
    curl -L git.io/antigen > ~/antigen.zsh
fi

# Copy to ~/.zshrc

if (whiptail --yesno "Copy .zshrc.template to home directory?" --title ".zshrc" $BOX_HEIGHT $BOX_WIDTH); then
    cp $HOME/.bash/.zshrc.template $HOME/.zshrc
fi

# Install fonts
if (whiptail --yesno "Install fonts for terminal?" --title "fonts" $BOX_HEIGHT $BOX_WIDTH); then
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
fi

####################################
# Brew install other terminal apps #
####################################
brew_installable=(
    "eza"
    "iterm2"
    "google-chrome"
    "rectangle"
    "spotify"
    "monitorcontrol"
    "tldr"
    "diff-so-fancy"
    "bat"
    "fzf"
    "ack"
    "volta"
    "lastpass-cli"
    "lazydocker"
    "slack"
    "htop"
    "session-manager-plugin"
    "terraform"
    "jq"
    "macmediakeyforwarder"
)
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

# Composer install psysh
if (whiptail --yesno "Install psysh (php shell)?" --title "Psysh" $BOX_HEIGHT $BOX_WIDTH); then
    composer global require psy/psysh
fi

# Setup fzf hotkeys
if [[ " ${choices[*]} " =~ "fzf" ]]; then
    /usr/local/opt/fzf/install
fi

if (whiptail --yesno "Configure git on this machine?" --title "Git Config" $BOX_HEIGHT $BOX_WIDTH); then
    # Get git author email
    GIT_AUTHOR_EMAIL=$(whiptail --inputbox "What is the email address you would like used for git?" --nocancel $BOX_HEIGHT $BOX_WIDTH $GIT_AUTHOR_EMAIL --title "Git Author Email" 3>&1 1>&2 2>&3)

    # Configure git
    git config --global core.excludesfile ~/.bash/.gitignore.global
    git config --global core.hooksPath ~/.bash/githooks
    git config --global user.name "Nathan Stanley"
    git config --global user.email $GIT_AUTHOR_EMAIL
    git config --global push.default current
    git config --global push.autoSetupRemote true
    git config --global pull.rebase false
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.ui true
    git config --global color.diff-highlight.oldNormal    "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal    "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"
    git config --global color.diff.meta       "11"
    git config --global color.diff.frag       "magenta bold"
    git config --global color.diff.commit     "yellow bold"
    git config --global color.diff.old        "red bold"
    git config --global color.diff.new        "green bold"
    git config --global color.diff.whitespace "red reverse"
    git config --global alias.unstage "restore --staged"
    git config --global alias.uncommit "reset HEAD^"
    git config --global alias.ignore "update-index --skip-worktree"
    git config --global alias.unignore "update-index --no-skip-worktree"
fi

##########
# Vim RC #
##########
if (whiptail --yesno "Copy .vimrc to this machine?" --title "Vimrc" $BOX_HEIGHT $BOX_WIDTH); then
    cp ~/.bash/.vimrc ~/.vimrc
fi

################
# AWS CLI TOOL #
################
# Install AWS CLI 2.x
if (whiptail --yesno "Install AWS CLI?" --title "AWS CLI" $BOX_HEIGHT $BOX_WIDTH); then
    curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
fi
