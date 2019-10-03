unset -f sub
function sub {
    for d in ./*/ ; do (cd "$d"; echo "${LBLUE}${PWD##*/}${default}"; $1; sleep 1 &); done
}
export -f sub

unset -f _vcomm
function _vcomm {
    vagrant ssh $1 -- -t $2
}
export -f _vcomm

unset -f chrome
function chrome {
    google-chrome http://localhost:$1 --incognito &
}
export -f chrome

