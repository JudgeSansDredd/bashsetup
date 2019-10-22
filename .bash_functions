unset -f _vcomm
function _vcomm {
    vagrant ssh $1 -- -t $2
}
export -f _vcomm

