alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias gstale='for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r'
alias gs="git status"
alias vssh="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /opt/spensa/openscout; /bin/bash;'; cd -"
alias vup="cd ~/Projects/ap/ap_web; vagrant up spensa; _vcomm spensa 'sudo supervisorctl stop all;'; cd -"
alias vhalt="cd ~/Projects/ap/ap_web; vagrant halt spensa; cd -"
alias vhaltf="cd ~/Projects/ap/ap_web; vagrant halt spensa -f; cd -"
alias vdestroy="cd ~/Projects/ap/ap_web; vagrant destroy -f; cd -"
alias vsp="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /opt/spensa/openscout; ./manage.py shell_plus;'; cd -"
alias vspsql="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /opt/spensa/openscout; ./manage.py shell_plus --print-sql;'; cd -"
alias vpipr="cd ~/Projects/ap/ap_web; vpip uninstall -yr requirements.txt; vpip install -r requirements.txt; cd -;"
alias vrs="cd ~/Projects/ap/ap_web; _vcomm spensa 'sudo supervisorctl restart openscout_uwsgi;'; cd -"
alias vrsall="cd ~/Projects/ap/ap_web; _vcomm spensa 'sudo supervisorctl restart all;'; cd -"
alias vstartall="cd ~/Projects/ap/ap_web; _vcomm spensa 'sudo supervisorctl start all;'; cd -"
alias vstopall="cd ~/Projects/ap/ap_web; _vcomm spensa 'sudo supervisorctl stop all;'; cd -"
alias vsass="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /opt/spensa/openscout; npm run build-sass;'; cd -"
alias vss="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh 2>&1 | grep -v \" 200 \";'; cd -"
alias vssv="cd ~/Projects/ap/ap_web; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh 2>&1;'; cd -"
alias vprov="cd ~/Projects/ap/ap_web; vagrant provision; cd -"
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias web="cd ~/Projects/ap/ap_web"
alias ops="cd ~/Projects/ap/ap_ops"
alias insights="cd ~/Projects/insights/ap_insights"
alias insightsops="cd ~/Projects/insights/ap_ops_insights"
alias scripts="cd ~/Projects/Scripts"
alias cat="bat"
alias ls="exa"
alias fzf="fzf --height 40% --reverse --preview 'cat {}'"
alias python="python3"
alias pip="pip3"
alias publickey="cat ~/.ssh/id_rsa.pub | pbcopy"
alias fut="futurize -0 -wn"
alias dnsnuke="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias addssh="ssh-add -K"
alias cwserve="cd ~/Projects/ap-cloudwatch; php -S localhost:8000 -t public; cd -"
alias dtnawsauth="aws-azure-login --profile dtn-aws-master --enable-chrome-seamless-sso"
alias dc="docker-compose"
alias dtnnpm="cd ~/Projects/dtn-eco-npm-registry; sh start.sh; cd -"
alias pa="php artisan"
alias athena="cd ~/Projects/hercules/athena"
alias hydra="cd ~/Projects/hercules/hydra"
alias pidown="ssh pihole 'sudo pihole disable 30s'"
