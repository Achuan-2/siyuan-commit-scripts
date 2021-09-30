#!/bin/bash
message=":bookmark: v0.8.6"
find ./ -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        echo -e "\e[1;31mCommitting\e[0m" $repo
        cd $repo
        git add -A
        git commit -m "${message}"
        git push origin main
        cd ../
        echo -e "done\n"
done
bash siyuan_get_sha1.sh