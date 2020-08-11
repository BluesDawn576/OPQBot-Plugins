#!/bin/bash
#--------------------------------------------
# 检测minecraft(java)新版本 并向群内推送
# author：BluesDawn576
# date: 2020.08.11
#--------------------------------------------
#检测mc新版本 sh脚本(需要OPQBot框架配合)
#本脚本需要安装jq(不是jQuery) 否则将无法运行
#本脚本支持单Q多群 多Q多群自行添加逻辑
#改一下脚本路径就可以每小时执行了 具体其他时长写法请了解Cron表达式
#添加定时计划 每小时执行  命令例:(echo "0 * * * * /home/pi/桌面/IOTQQ_3.0.0_linux_arm64/Time/time.sh" ;crontab -l) |crontab
#或使用宝塔面板添加计划任务 任务类型为Shell脚本

#填写你的机器人QQ号
SelfQQ=""
#发送群号 支持多群 多群 一个空格分开
RevGroupArr=("114514" "1919810")
#配置文件储存位置(建议在机器人目录，例如:/root/公共/OPQBot/Config/mc-checker.dat)
datPath=""
#端口号 你运行机器人的那个端口
Post="8888"

#检测文件是否存在 不存在将自动创建
if [ ! -f "$datPath" ] ; then
    touch "$datPath"
    release="0.0"
    snapshot="0.0"
    echo "文件不存在，初始化版本号"
else
    release=$(echo $(cat $datPath) | cut -d \, -f 1)
    snapshot=$(echo $(cat $datPath) | cut -d \, -f 2)
    echo "文件存在"
fi

str=$(curl -s http://launchermeta.mojang.com/mc/game/version_manifest.json)
#解析json 需要安装jq
Id=$(echo $str|jq -r '.versions[0].id')
Type=$(echo $str|jq -r '.versions[0].type')
Time=$(echo $str|jq -r '.versions[0].time')
#判断类型
if [ $Type = "release" ] ; then
    if [[ $release != $Id ]] ; then
        _type="正式版"
        isNew=true
cat > $datPath << END_TEXT
$Id,$snapshot
END_TEXT
    fi
elif [ $Type = "snapshot" ] ; then
    if [[ $snapshot != $Id ]] ; then
        _type="快照"
        isNew=true
cat > $datPath << END_TEXT
$release,$Id
END_TEXT
    fi
fi
if  [[ $isNew == true ]] ; then
for i in "${!RevGroupArr[@]}"; do
RevGroup=${RevGroupArr[$i]}
curl "http://127.0.0.1:$Post/v1/LuaApiCaller?qq=$SelfQQ&funcname=SendMsg&timeout=10" -H 'Content-Type: application/json' --data-binary '{"toUser":'${RevGroup}',"sendToType":2,"sendMsgType":"TextMsg","content":"发现'$_type'更新: '$Id'\n时间: '$Time'","groupid":0,"atUser":0}'
done
fi