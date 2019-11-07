######################
# Setup Oh My Zshell #
######################

# Install oh my zshell (this will ask to switch shells if you have not
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy to ~/.zshrc
cp ./.zshrc ~/.zshrc

####################################
# Brew install other terminal apps #
####################################

# Brew install command line tools
brew install tldr diff-so-fancy bat fzf

# Setup fzf hotkeys and such
/usr/local/opt/fzf/install

# Configure git to use diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# Configure git to use different colors for diffs
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
