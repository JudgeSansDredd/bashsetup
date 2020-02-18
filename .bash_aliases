alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias gstale='for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r'
alias gs="git status"
alias vssh="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; /bin/bash;'; cd -"
alias vup="cd ~/Projects/ap_ops; vagrant up spensa; cd -"
alias vhalt="cd ~/Projects/ap_ops; vagrant halt spensa; cd -"
alias vdestroy="cd ~/Projects/ap_ops; vagrant destroy -f; cd -"
alias vsp="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; ./manage.py shell_plus;'; cd -"
alias vpipr="cd ~/Projects/ap_web; vpip uninstall -yr requirements.txt; vpip install -r requirements.txt; cd -;"
alias vrs="cd ~/Projects/ap_ops; _vcomm spensa 'sudo supervisorctl restart openscout_uwsgi;'; cd -"
alias vrsall="cd ~/Projects/ap_ops; _vcomm spensa 'sudo supervisorctl restart all;'; cd -"
alias vsass="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; npm run build-sass;'; cd -"
alias vss="cd ~/Projects/ap_ops; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh 2>&1 | grep -v \" 200 \";'; cd -"
alias vssv="cd ~/Projects/ap_ops; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh 2>&1;'; cd -"
alias vprov="cd ~/Projects/ap_ops; vagrant provision; cd -"
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias web="cd ~/Projects/ap_web"
alias ops="cd ~/Projects/ap_ops"
alias cat="bat"
alias ls="exa"
alias fzf="fzf --height 40% --reverse --preview 'cat {}'"
alias python="python3"
alias pip="pip3"
alias scripts="cd ~/Projects/Scripts"
alias publickey="cat ~/.ssh/id_rsa | pbcopy"
alias fut="futurize -0 -wn"
