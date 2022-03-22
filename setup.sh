#!/bin/bash
######################
# Setup Oh My Zshell #
######################

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install iterm
brew install --cask iterm2

# Install zshell
brew install zsh

# Install oh my zshell (this will ask to switch shells if you have not
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy to ~/.zshrc
cp ./.zshrc.template ~/.zshrc

# Install fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Brew install Teams
brew install --cask microsoft-teams

####################################
# Brew install other terminal apps #
####################################

# Brew install php 7.3
brew install php@7.3
brew link --overwrite --force php@7.3

# Install php formatter
brew install php-cs-fixer

# Brew install Google Chrome
brew install --cask google-chrome

# Brew install rectangle
brew install --cask rectangle

# Brew install Spotify
brew install --cask spotify

# Brew install virtualbox
brew install virtualbox

# Brew install Vagrant
brew install vagrant

# Brew install ansible
brew install --cask ansible

# Brew install command line tools
brew install tldr diff-so-fancy bat fzf ack exa

# Brew install aws session manager
brew install --cask session-manager-plugin

# Brew install alfred
brew install --cask alfred

# Brew install composer
brew install composer

# Brew install node 
brew install node

# Brew install volta (node version manager)
brew install volta

# Brew install terraform
brew install terraform

# Brew install jq
brew install jq

# Setup fzf hotkeys and such
/usr/local/opt/fzf/install

# Copy global git ignore
cp ./.gitignore.global.template ~/.gitignore.global

# Configure git
git config --global core.excludesfile ~/.gitignore.global
git config --global user.name "Nathan Stanley"
git config --global user.email "chemapfours@gmail.com"
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
