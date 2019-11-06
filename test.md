# Switch to zshell if not already there
    chsh -s /bin/zsh
# Clone this directory
    git clone git@github.com:JudgeSansDredd/bashsetup.git ~/.bash
# Install Oh My Zshell
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Install syntax highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins zsh-syntax-highlighting
# Install auto-suggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Edit ~/.zshrc
## Set DEFAULT_USER to your usual login
    DEFAULT_USER='nathan'
## Source your bash file
    source ~/.bash/.bash_origin
## Change the theme to agnoster
    ZSH_THEME="agnoster"
## Add Plugins
    plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
## Source the oh my zshell shell script
    source $ZSH/oh-my-zsh.sh
# Install tldr
    brew install tldr
# Install diff-so-fancy
    brew install diff-so-fancy
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
# Install bat
    brew install bat
This is already aliased to `cat`