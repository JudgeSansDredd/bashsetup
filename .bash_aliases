alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias vssh="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; /bin/bash;'; cd -"
alias vup="cd ~/Projects/ap_ops; vagrant up spensa; cd -"
alias vhalt="cd ~/Projects/ap_ops; vagrant halt spensa; cd -"
alias vdestroy="cd ~/Projects/ap_ops; vagrant destroy -f; cd -"
alias vsp="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; ./manage.py shell_plus;'; cd -"
alias vrs="cd ~/Projects/ap_ops; _vcomm spensa 'sudo supervisorctl restart openscout_uwsgi;'; cd -"
alias vrsall="cd ~/Projects/ap_ops; _vcomm spensa 'sudo supervisorctl restart all;'; cd -"
alias vsass="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; npm run build-sass;'; cd -"
alias vss="cd ~/Projects/ap_ops; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh'; cd -"
alias vprov="cd ~/Projects/ap_ops; vagrant provision; cd -"
alias vpip="_vpip"
alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias web="cd ~/Projects/ap_web"
alias ops="cd ~/Projects/ap_ops"
alias cat="bat"
alias ls="exa --group-directories-first"
alias gs="git status"
alias fzf="fzf --height 40% --reverse --preview 'cat {}'"

