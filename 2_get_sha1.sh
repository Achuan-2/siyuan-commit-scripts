#!/bin/bash

# into the upper folder
cd ../

HOME=`pwd`

# generate json
echo -e "\e[1;36m\ntemp.json.json started generating\n\e[0m"
echo "" > ${HOME}/temp.json
echo -e "{ \n    \"repos\": [" >> ${HOME}/temp.json

# find + absolute path -> return absolute path
find ${HOME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        cd $repo
        # rexp: (?<=exp) match after the exp
        # grep : -P use regular expression，-o print the matched parts
        # git rev-parse HEAD -> get the latest SHA-1
        git remote -v | tail -n 1 | grep -P "(?<=github.com\/)[^\.]+" -o | xargs -i echo "    \"{}@`git rev-parse HEAD`\","  

done >> ${HOME}/temp.json

echo -e "    ] \n}" >> ${HOME}/temp.json

# info
echo -e "\e[1;36m\ntemp.json.json generated successfully\n\e[0m"
