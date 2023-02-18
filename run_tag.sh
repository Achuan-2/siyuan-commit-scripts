#!/bin/bash

SCRIPT=`pwd`

run(){

    ####打标签，GitHub Action自动Release，等待思源集市会获取最新Hash####
    VERSION="v1.5.4"
    release
}
release() {
    source ${SCRIPT}/3_tag.sh
    # 添加标签
    add_tag $VERSION

}

run