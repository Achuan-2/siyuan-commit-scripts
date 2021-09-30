#!/bin/bash

# set author name
AUTHOR="Achuan-2"

# generate json
## git rev-parse HEAD （get the latest sha1
echo "" > ./themes.json
echo -e "{ \n    \"repos\": [" >> ./themes.json
find . -maxdepth 1 -type d -name "siyuan*" | while read repo;
    do  
        cd $repo
        git remote -v | tail -n 1 | grep -o "${AUTHOR}/[^\.]*" | xargs -i echo "    \"{}@`git rev-parse HEAD`\"," 
        cd ../
done >> ./themes.json
echo -e "    ] \n}" >> ./themes.json

# info
echo -e "\e[1;31m\ntheme.json generated successfully\n\e[0m"
