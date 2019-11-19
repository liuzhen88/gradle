#!/bin/bash
projectdir=/data/code/$2/
dockerdist=/data/code/aife-test-dist/

if [ $1 ]
then
    echo -e "\033[36m tagId = $1 \033[0m" 
    cd $projectdir
    git checkout test
    git pull --all

    if git rev-parse -q --verify "refs/tags/$1" >/dev/null; then
        git checkout $1
        yarn install
        yarn run build
        yarn run build:doc
        npm publish $1
        rm -rf $dockerdist*
        cp -r ./docs/* $dockerdist
    else
        echo "git does not find $1 tag"
    fi
else
    echo "tag param not found"
fi
