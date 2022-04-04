#!/bin/bash
main() {
    VERSION="v1.2.1"
    # delete_tag
    add_tag
}

add_tag() {
    echo -e "\e[1;31m\nRun tag.sh\n\e[0m" 

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
}


delete_tag() {
    echo -e "\e[1;31m\nRun Tag Delete\n\e[0m" 
    cd ../

    HOME=`pwd`
    echo $message
    find ${HOME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
        do  
            echo -e "\e[1;31mDeleting\e[0m" $repo
            cd $repo
            echo `pwd`
            git tag -d $VERSION
            git push origin :refs/tags/$VERSION
            echo -e "done\n"
    done
}

main
