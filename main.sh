#!/bin/bash
export THEME="Tsundoku"
#--！-----每次更新记得修改更新信息-----------------#
export version="v0.9.4"
export update_content="change blockquote style"
#--！----------------------#
bash ./1_repo_commit.sh
bash ./2_get_sha1.sh
bash ./3_siyuan_bazzar.sh