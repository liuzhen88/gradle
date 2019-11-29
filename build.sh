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

        docker stop aife-ui
        docker rm aife-ui
        docker run -it -d -p 4874:80 -v /data/code/aife-ui-dist/:/usr/share/nginx/html/ --name aife-ui nginx:stable-alpine
    
        docker stop test
        docker rm test
        docker run -it -d -p 9527:80 -v /data/code/aife-ui-dist/:/usr/share/nginx/html/ --name test nginx:stable-alpine
    else
        echo "git does not find $1 tag"
    fi
else
    echo "tag param not found"
fi
