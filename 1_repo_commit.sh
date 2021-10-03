echo -e "\e[1;31m\nRun 1_repo_commit.sh\n\e[0m" 
cd ../
HOME=`pwd`
message=":bookmark: v0.8.7"
find ${HOME} -maxdepth 1 -type d -name "siyuan-themes*" | while read repo;
    do  
        echo -e "\e[1;31mCommitting\e[0m" $repo
        cd $repo
        echo `pwd`
        git add -A
        git commit -m "${message}"
        git push origin main
        echo -e "done\n"
done