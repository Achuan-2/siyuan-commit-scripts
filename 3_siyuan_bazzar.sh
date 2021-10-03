
# set commit message
message=":lipstick: Update Tsundoku v0.8.7"

# set path
cd ..
BAZAAR=`pwd`/bazaar
HOME=`pwd`


# update remote repo to local
cd ${BAZAAR}
git restore .
git pull

# change bazaar json
echo -e "\e[1;34m\nchanging theme.json in bazaar\n\e[0m"
find ${HOME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        cd $repo
        # rexp: (?<=exp) match after the exp
        # grep : -P use regular expression，-o print the matched parts
        name=`git remote -v | tail -n 1 | grep -P "(?<=github.com\/)[^\.]+" -o`
        # git rev-parse HEAD -> get the latest SHA-1
        sha1=`git rev-parse HEAD`
        sed -i "s|${name}@[^\"]*|"${name}@${sha1}"|g" ${BAZAAR}/themes.json 
        echo -e "\e[1;34m\n...\n\e[0m"
done 


# git commit and push 
cd ${BAZAAR}
git add -A
git commit -m "${message}"
git push
echo -e "\e[1;34m\npushed to bazaar over\n\e[0m"