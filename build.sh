#!/bin/bash
projectdir=/data/code/aife-ui/
dockerdist=/data/code/aife-ui-dist/

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
        npm version $1
        npm publish
        rm -rf $dockerdist*
        cp -r ./docs/* $dockerdist
    else
        echo "git does not find $1 tag"
    fi
else
    echo "tag param not found"
fi
