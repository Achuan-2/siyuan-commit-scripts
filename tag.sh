#!/bin/bash
echo -e "\e[1;31m\nRun tag.sh\n\e[0m" 
VERSION="v1.1.4"
cd ../

HOME=`pwd`
echo $message
find ${HOME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        echo -e "\e[1;31mTagging\e[0m" $repo
        cd $repo
        echo `pwd`
        git tag $VERSION
        git push origin --tags
        echo -e "done\n"
done