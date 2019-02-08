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

unset -f new_ef_project
function new_ef_project {
	composer create-project --prefer-dist laravel/laravel:5.7 $1
	cd $1
	rm database/migrations/*
	composer config repositories.sfp-commands vcs https://gitlab+deploy-token-2:ZHwQJz3Pkmg8WDGK-cWU@gitlab.sfp.cc/cms/commands.git
	composer require sfp/commands
	php -r "include('vendor/autoload.php'); SFP\Commands\Commands\ProjectInit::patch();"
	php artisan sfp:command:patch
	php -r "file_put_contents('resources/views/welcome.blade.php', str_replace('<a href=\"{{ route(\'register\') }}\">Register</a>', '', file_get_contents('resources/views/welcome.blade.php')));"
	echo -ne '\n\n\n' | php artisan sfp:vagrant:init
	vagrant up
	echo -e "\n\n${LBLUE}EF Project up and running. Remember to ${ORANGE}php artisan sfp:require ${LBLUE}some modules and ${ORANGE}php artisan sfp:provide"
}
export -f new_ef_project

unset -f _pacc
function _pacc {
	php artisan cache:clear
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
