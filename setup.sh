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
if [ -d "./bitclust" ]
then
    echo "bitclust directory already exists"
else
    run git clone https://github.com/rurema/bitclust.git bitclust
fi

if [ -d "./doctree" ]
then
    echo "doctree directory already exists"
else
    run git clone git@192.168.2.6:translation/rurima-ruby-2-0.git doctree
fi

# run git clone https://github.com/groonga/groonga.git
# run cd groonga
# run ./autogen.sh
# run ./configure --prefix=${base_dir}/local --disable-document
# run make
# run make install
# run cd -

if [ -d "./rroonga" ]
then
    echo "rroonga directory already exists"
else
    run git clone https://github.com/ranguba/rroonga.git
    run cd rroonga
    run export PKG_CONFIG_PATH=${base_dir}/local/lib/pkgconfig
    run ruby extconf.rb
    run make
    run cd -
fi

if [ -d "./racknga" ]
then
    echo "racknga directory already exists"
else
    run git clone https://github.com/ranguba/racknga.git
fi

run cd rurema-search
run ./update.sh
