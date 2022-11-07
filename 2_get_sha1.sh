#!/bin/bash

SCRIPTS=`pwd`

# into the upper folder
cd ../

THEME=`pwd`

# generate json
echo -e "\e[1;36m\n$THEME temp.json.json started generating\n\e[0m"
echo "" > ${SCRIPTS}/temp.json
echo -e "{ \n\t\"repos\": [" >> ${SCRIPTS}/temp.json
echo -e "\t\"start\"," >> ${SCRIPTS}/temp.json
# find + absolute path -> return absolute path
find ${THEME} -maxdepth 1 -type d -name "Tsundoku*" | while read repo;
    do  
        cd "$repo"
        # rexp: (?<=exp) match after the exp
        # grep : -P use regular expression，-o print the matched parts
        # git rev-parse HEAD -> get the latest SHA-1
        git remote -v | tail -n 1 | grep -P "(?<=github.com\/)[^\.]+" -o | xargs -i echo -e "\t\"{}@`git rev-parse HEAD`\","  

done >> ${SCRIPTS}/temp.json 
echo -e "\t\"end\"" >> ${SCRIPTS}/temp.json
echo -e "\t]\n}" >> ${SCRIPTS}/temp.json

# info
echo -e "\e[1;36m\n${SCRIPTS}/temp.json.json generated successfully\n\e[0m"
