alias pa="php artisan"
alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias gs="git status"
alias ls="ls -laF"
alias homestead="composer require laravel/homestead --dev; php vendor/laravel/homestead/bin/homestead make; vagrant up"
alias cat="bat"
alias ls="exa --group-directories-first"
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias fzf="fzf --height 40% --reverse --preview 'cat {}'"
