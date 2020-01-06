#!/bin/bash
set -e

function resetdb(){
    echo "resetting db..."
    sh -c "./scripts/resetdb.sh --force"
}

function create_tree(){
    echo "install create tree utility"
    go install ./cmd/createtree
    echo "creating merkle tree"
    # admin_server is hardlinked to tlserver hostname
    # this will print out the tree_id created. required for later steps
    createtree --admin_server=tlserver:8090 --private_key_format=PrivateKey --pem_key_path=/go/src/github.com/google/trillian/testdata/log-rpc-server.privkey.pem --pem_key_password=towel --signature_algorithm=ECDSA
}

function tlserver(){
    echo "starting tlserver..."
    sh -c "trillian_log_server --config=/server.cfg"
}

function tlsigner(){
    echo "starting tlsigner..."
    sh -c "trillian_log_signer --config=/signer.cfg"
}

function core(){
    echo "invoking core..."
}

while test $# -gt 0
do
    case "$1" in
        mysql) mysql -utest -pzaphod -hmysql cttest
            ;;
        bash) bash
            ;;
        --resetdb) resetdb
            ;;
        --createtree) create_tree
            ;;
        --tlserver) tlserver
            ;;
        --tlsigner) tlsigner
            ;;
        --core) core
            ;;
        *) echo "ignoring argument $1"
            ;;
    esac
    shift
done


exec "$@"
