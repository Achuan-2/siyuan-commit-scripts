# siyuan-commit-scripts
- create_time: 2021-10-03 Sun
- update_time：2022.04.05  Tue


由于我目前在思源笔记集市需要维护四个主题，且每次更新基本是需要同时更新四个主题的，如果按手动的方法，我需要

1. 先把修改提交到自己的主题 repo，push 到 github
2. 一个主题一个主题复制 40 位的 commit SHA-1 码，一个个修改 bazaar 里的 themes.json
3. 然后在pull request

这样维护主题起来就很麻烦了，而且每次提交我害怕把不同主题的 SHA-1 搞混搞漏，还需要校对一下。

无奈，正好最近在接触 shell 脚本，就打算用 shell 写一个自动化提交到集市的脚本

主要功能大概是

1. 由于我的主题 repo 都是 siyuan-themes 开头，且都放在 conf/themes 文件夹下，于是希望脚本可以识别我的主题 repo，然后批量把修改上传到 github。
2. 各个主题生成 SHA-1 码，生成一个 temp.json 文件，这样我可以直接把生成的 json 内容手动替换 bazaar 的 json
3. 要是可以一步到位，直接修改 bazaar 中 json 内对应我 repo 的文字内容，直接提交就好啦。这样我只负责修改主题，主题一修改好，确定没问题，直接运行脚本就好。


结果嘛……看起来还不错

先展示下我的工作区，工作区就在 conf/themes, 我把 bazaar 和自己的主题 repo 都 clone 到了 themes 文件内，后面脚本都是按照这个文件目录编排来的，当然你可以根据自己的需要修改脚本。

![20220404141339_2022-04-04](https://cdn.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/README/20220404141339_2022-04-04.png)

接下来简要介绍下我的脚本

## repo_commit.sh

对应第一点需求，识别 siyuan-themes 开头的文件夹，然后提交修改，push 到 Github

```bash
#!/bin/bash
echo -e "\e[1;31m\nRun 1_repo_commit.sh\n\e[0m" 
cd ../

THEME=`pwd`
echo $message
find ${THEME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        echo -e "\e[1;31mCommitting\e[0m" $repo
        cd $repo
        echo `pwd`
        git add -A
        git commit -m "${message}"
        git push origin main
        echo -e "done\n"
done
```

## get_sha1.sh

对应第二点需求，主题提交完成后，生成 temp.json 文件，得到 "repo_name@SHA-1" 格式的内容

```bash
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
find ${THEME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        cd $repo
        # rexp: (?<=exp) match after the exp
        # grep : -P use regular expression，-o print the matched parts
        # git rev-parse HEAD -> get the latest SHA-1
        git remote -v | tail -n 1 | grep -P "(?<=github.com\/)[^\.]+" -o | xargs -i echo -e "\t\"{}@`git rev-parse HEAD`\","  

done >> ${SCRIPTS}/temp.json 
echo -e "\t\"end\"" >> ${SCRIPTS}/temp.json
echo -e "\t]\n}" >> ${SCRIPTS}/temp.json

# info
echo -e "\e[1;36m\n${SCRIPTS}/temp.json.json generated successfully\n\e[0m"

```

## siyuan_bazaar.sh

对应第三点需求，先fork 【siyuan_bazaar](https://github.com/siyuan-note/bazaar)，然后clone放到themes文件夹下

直接修改 fork来的bazaar 中自己 repo 的对应行内容，先同步bazaar的内容覆盖本地repo，然后再提交修改强制 push 到 Github。这样只需要打开自己fork来的repo，点击pull request就可以了

```bash
#!/bin/bash
# set commit message

message="Update ${THEME} ${VERSION}"
# set path
cd ..
BAZAAR=`pwd`/bazaar
THEME=`pwd`


# update remote repo to local
cd ${BAZAAR}

# update local repo from fork repo
git restore .
git fetch fork
git reset --hard fork/main


# change bazaar json
echo -e "\e[1;34m\nchanging theme.json in bazaar\n\e[0m"
find ${THEME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
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
git push -f
echo -e "\e[1;34m\npushed to bazaar over\n\e[0m"
```

