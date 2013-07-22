#!/bin/sh

base_dir=$(cd "$(dirname "$0")" && pwd)

run()
{
    "$@"
    if test $? -ne 0; then
        echo "Failed $@"
        exit 1
    fi
}

set -x

#run ruby -S gem install rack pkg-config

run cd ${base_dir}/..

run git clone https://github.com/ranguba/rroonga.git
run cd rroonga
run export PKG_CONFIG_PATH=${base_dir}/local/lib/pkgconfig
run ruby extconf.rb
run make
run cd -

run git clone https://github.com/ranguba/racknga.git

run cd rurema-search
run ./update.sh
