# BDbot
![license](https://img.shields.io/github/license/BluesDawn576/OPQBot-Plugins) 
![status](https://img.shields.io/badge/status-停止维护-red)

> 仓库已迁移(重构) -> [BDbot_Plugins](https://github.com/BluesDawn576/BDbot_Plugins)

『BDbot』个人插件仓库

本仓库内容需要借助[OPQbot](https://github.com/OPQBOT/OPQ)才能使用

### 目前已实现的功能（带\*表示已开源）

#### 音游相关

Arcaea查分

Osu查分 (目前仅支持个人信息查询)

\*bandori邦邦车站 ([BandoriStation](https://github.com/maborosh/BandoriStation)) `!ycm`

#### minecraft相关

\*自定义mc服务器查询 `!mc [地址]`

MC群定制服务器查询（每群仅支持一个服务器） `查询服务器`

\*检测minecraft (java)版本更新情况，并推送至指定群内（借助shell定时任务）


#### 群内娱乐

\*一言，随机一句话 `!一言`

\*让bot决定你要做什么（支持多选项） `![选项1]还是[选项2]`

随机一张生草图 `!生草`

\*答案之书 `!答案之书 [问题]`


#### 气象查询

\*最新气象云图查询

+ 风云二号
    + 真彩图 `!云图 fy2`
    + 西北太平洋云图 `!云图 fy2f`
+ 风云四号
    + 中国区真彩图 `!云图 fy4a`
    + 全圆盘真彩图 `!云图 fy4af`
+ 向日葵8号机动观测 `!云图 h8`

\*当天降水量预报查询（24/48/72，缺省24）`!预报 [小时]`