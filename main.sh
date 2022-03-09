#!/bin/bash
export THEME="Tsundoku"
#--！-----每次更新记得修改更新信息-----------------#
# :lipstick:取消页签动画
# :bookmark: v1.1.2
# :sparkles: 更新插件
# :art: [theme.css] reorganize
export message=":art: [theme.css] reorganize"

#--！----------------------#
bash ./1_repo_commit.sh
bash ./2_get_sha1.sh


# bash ./3_siyuan_bazzar.sh