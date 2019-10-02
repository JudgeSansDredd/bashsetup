unset -f sub
function sub {
    for d in ./*/ ; do (cd "$d"; echo "${LBLUE}${PWD##*/}${default}"; $1; sleep 1 &); done
}
export -f sub

unset -f _vcomm
function _vcomm {
    vagrant ssh -- -t '$1'
}
export -f _vcomm

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

