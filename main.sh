#!/bin/bash

SCRIPT=`pwd`

run(){
    ####主题日常 commit####
    # message=":bookmark: v1.2.4"
    # commit

    ####上交到集市,自行前往https://github.com/Achuan-2/bazaar pull request####
    VERSION="v1.2.4"
    release
}
release() {
    source ${SCRIPT}/3_tag.sh
    # 添加标签
    add_tag $VERSION
    # 发布到集市
    cd  ${SCRIPT}
    bash ${SCRIPT}/4_bazaar.sh $VERSION

}
commit() {
    bash ${SCRIPT}/1_repo_commit.sh $message
}
run