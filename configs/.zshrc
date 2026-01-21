# Source antigen
source $HOME/.bash/configs/antigen.zsh

# Load oh-my-zsh
antigen use oh-my-zsh

# Load plugins
antigen bundle git
# antigen bundle git-auto-fetch
antigen bundle gitfast
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle jump

# Load theme
# NOTE: If you're using agnoster as your theme
# antigen theme agnoster

# Apply antigen changes
antigen apply

# Change default user to suppress 'nstanley@hostname'
DEFAULT_USER='nstanley'

# Source custom profile settings
source $HOME/.bash/bash_origin

# Setup fzf (make sure this is after sourcing from bash_origin)
source <(fzf --zsh)

# Load theme
# NOTE: If you're using pure as your theme, use this section
# fpath+=("$(brew --prefix)/share/zsh/site-functions")
# autoload -U promptinit; promptinit
# prompt pure

# Load theme
# NOTE: If you're using starship
eval "$(starship init zsh)"

eval "$(jenv init -)"
