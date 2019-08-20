unset -f sub
function sub {
    for d in ./*/ ; do (cd "$d"; echo "${LBLUE}${PWD##*/}${default}"; $1; sleep 1 &); done
}
export -f sub

unset -f chrome
function chrome {
    google-chrome http://localhost:$1 --incognito &
}
export -f chrome

unset -f _pacc
function _pacc {
	php artisan cache:clear
	php artisan optimize:clear
	php artisan config:clear
	php artisan route:clear
	php artisan view:clear
	composer clear-cache
	composer dump-autoload
}
export -f _pacc

unset -f open_project
function open_project {
	vagrant up &
	subl .
	sh /opt/navicat/start_navicat &
	chrome 8088
}
export -f open_project

unset -f binarybuild
function binarybuild {
	box build
	cp sfp.phar /usr/local/bin/sfp
}
export -f binarybuild
