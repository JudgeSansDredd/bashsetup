alias navicat="sh /opt/navicat/start_navicat &"
alias pa="php artisan"
alias gs="git status"
alias gl="git log --graph"
alias gd="git diff"
alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias newef="new_ef_project"
alias fetchall="sub 'git fetch --all --prune'"
alias pacc="_pacc"
alias startwork="open_project"
alias rotateright="xrandr --output HDMI-1 --rotate right"
alias rotateleft="xrandr --output HDMI-1 --rotate left"
alias rotatenormal="xrandr --output HDMI-1 --rotate normal"
alias rotateinverted="xrandr --output HDMI-1 --rotate inverted"
alias phpswitch="sudo update-alternatives --config php"
alias copykey="cat ~/.ssh/id_rsa.pub | pbcopy"
alias subl="open -a /Applications/Sublime\ Text.app"
