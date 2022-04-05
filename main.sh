#!/bin/bash

SCRIPTS=`pwd`
#---------1.commit--------------#
export message=":bookmark: v1.2.2"
# bash ${SCRIPT}/1_repo_commit.sh

<<commit_message
:lipstick: 美化样式
:bookmark: v版本号
:sparkles: 功能更新
:art: reorganize
:bug: fix bug
:memo: docs改进
:pencil: 错别字
commit_message


#---------2.get_sha1--------------#
bash ${SCRIPT}/2_get_sha1.sh

#----------3.打标签--------------#
source ${SCRIPT}/3_tag.sh
export VERSION="v1.2.2"
# 删除标签
# delete_tag $VERSION
# 添加标签
# add_tag $VERSION

#----------4.提交到bazzar--------------#
export THEME="Tsundoku"
bash ${SCRIPT}/4_bazaar.sh


#自行前往https://github.com/Achuan-2/bazaar pull request