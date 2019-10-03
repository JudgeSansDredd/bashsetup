alias gs="git status"
alias gl="git log --graph"
alias gd="git diff -w"
alias grm='git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias ls="ls -laF"
alias vssh="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; /bin/bash;'; cd -;"
alias vup="cd ~/Projects/ap_ops; vagrant up spensa; _vcomm spensa 'sudo supervisorctl start openscout_uwsgi'; cd -;"
alias vhalt="cd ~/Projects/ap_ops; vagrant halt spensa; cd -;"
alias vsp="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; ./manage.py shell_plus'; cd -;"
alias vrs="cd ~/Projects/ap_ops; _vcomm spensa 'sudo supervisorctl restart openscout_uwsgi;'; cd -;"
alias vsass="cd ~/Projects/ap_ops; _vcomm spensa 'cd /opt/spensa/openscout; npm run build-sass;'; cd -;"
alias vss="cd ~/Projects/ap_ops; _vcomm spensa 'cd /spensa; sh run_platform_dev_server_letsencrypt.sh'; cd -;"
