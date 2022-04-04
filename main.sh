#!/bin/bash

#--！-----每次更新记得修改更新信息-----------------#
# :lipstick: 美化
# :bookmark: v1.1.9
# :sparkles: 功能更新
# :art: reorganize
# :bug: 修复代码块行号适配问题
# :memo:
export message=":bookmark: v1.2.1"

#--！----------------------#
bash ./1_repo_commit.sh
bash ./2_get_sha1.sh


# 目前思源bazaar必须要pull request，不能像之前一样有权限直接修改了
# bash ./3_siyuan_bazzar.sh
