#!/bin/bash
# Whiptail stuff
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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install zshell
brew install iterm2 zsh

# Install oh my zshell (this will ask to switch shells if you have not
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy to ~/.zshrc
cp $HOME/.bash/.zshrc.template $HOME/.zshrc

# Install fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

####################################
# Brew install other terminal apps #
####################################

# Brew install php 7.3
brew install php@7.3
brew link --overwrite --force php@7.3

brew install google-chrome rectangle spotify monitorcontrol alfred ansible tldr diff-so-fancy bat fzf ack exa lastpass-cli lazydocker fig slack htop composer session-manager-plugin node volta terraform jq

# Composer install psysh
composer global require psy/psysh

# Setup fzf hotkeys and such
/usr/local/opt/fzf/install

# Get git author email
GIT_AUTHOR_EMAIL=$(whiptail --inputbox "What is the email address you would like used for git?" --nocancel $BOX_HEIGHT $BOX_WIDTH $GIT_AUTHOR_EMAIL --title "Git Author Email" 3>&1 1>&2 2>&3)

# Configure git
git config --global core.excludesfile ~/.bash/.gitignore.global
git config --global core.hooksPath ~/.bash/githooks
git config --global user.name "Nathan Stanley"
git config --global user.email $GIT_AUTHOR_EMAIL
git config --global push.default current
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
git config --global alias.ignore "update-index --skip-worktree"
git config --global alias.unignore "update-index --no-skip-worktree"

##########
# Vim RC #
##########
cp ~/.bash/.vimrc ~/.vimrc

################
# AWS CLI TOOL #
################
# Install AWS CLI 2.x
curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
