alias pa="php artisan"
alias gs="git status"
alias gl="git log --graph"
alias gd="git diff -w"
alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias pacc="_pacc"
alias ls="ls -laF"
