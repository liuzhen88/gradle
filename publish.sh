#!/bin/bash
projectdir=/Users/lz/liuzhen/codes/test-gradle/

if [ $1 ]; then
    cd $projectdir
    git checkout test
    echo "version is $1"
    npm version $1
    git push origin test
    npm publish .
else
    echo "npm version not found"
fi