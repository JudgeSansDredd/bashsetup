# Switch to zshell if not already there
chsh -s /bin/zsh

# Install Oh My Zshell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy to ~/.zshrc
cp ./.zshrc ~/.zshrc

# Brew install command line tools
brew install tldr diff-so-fancy bat exa

# Configure git to use diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
