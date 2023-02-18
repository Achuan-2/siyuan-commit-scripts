#!/bin/bash

SCRIPT=`pwd`

run(){
    ####主题日常 commit####
    message=":bookmark: v1.5.5"
    commit

}


commit() {
    bash ${SCRIPT}/1_repo_commit.sh $message
}
run