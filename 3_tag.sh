#!/bin/bash


add_tag() {
    echo -e "\e[1;31m\nRun tag.sh\n\e[0m" 

    cd ../

    THEME=`pwd`
    echo $message
    find ${THEME} -maxdepth 1 -type d -name "Tsundoku*" | while read repo;
        do  
            echo -e "\e[1;31mTagging\e[0m" $repo
            cd "$repo"
            echo `pwd`
            git tag $1
            git push origin --tags
            echo -e "done\n"
    done
}


delete_tag() {
    echo -e "\e[1;31m\nRun Tag Delete\n\e[0m" 
    cd ../

    THEME=`pwd`
    echo $message
    find ${THEME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
        do  
            echo -e "\e[1;31mDeleting\e[0m" $repo
            cd $repo
            echo `pwd`
            git tag -d $1
            git push origin :refs/tags/$1
            echo -e "done\n"
    done
}

