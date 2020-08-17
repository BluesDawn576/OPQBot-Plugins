--BluesDawn
local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUin ==2126622797 then --防止自我复读
		  return 1 end
if data.Content == "!云图" or data.Content == "！云图" then
        Time = os.date('!%Y%m%d') --取UTC时间 年月日 例20200817
        Hour = os.date('!%H') --取UTC时间 小时 例12
        if(tonumber(os.date('!%M')) < 30) then --如果当前小于30分钟，小时数减1
            Hour = string.format("%02d",Hour - 1)
        end
        url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nsmc_wxcl_asc_e99_achn_lno_py_" ..Time..Hour.. "1500000.jpg"
        text = ""
elseif (string.find(data.Content, "!预报") == 1 or string.find(data.Content, "！预报") == 1) then
    if(string.find(data.Content, "!") == 1) then
        key = data.Content:gsub("!预报", "")
    elseif(string.find(data.Content, "！") == 1) then
        key = data.Content:gsub("！预报", "")
    end
    Time = os.date('%Y%m%d') --取系统本地时间 年月日
    text = ""
    if(key == "24" or key == " 24" or key == "") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then --0点到6点
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "今日还没有24小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 10) then --7点到10点
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000002400.jpg"
        elseif(tonumber(os.date('%H')) > 10 and tonumber(os.date('%H')) <= 18) then --11点到18点
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "060002400.jpg"
        elseif(tonumber(os.date('%H')) > 18) then --19点到23点
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120002400.jpg"
        end
    elseif(key == "48" or key == " 48") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "今日还没有48小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000004800.jpg"
        elseif(tonumber(os.date('%H')) > 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120004800.jpg"
        end
    elseif(key == "72" or key == " 72") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "今日还没有72小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000007200.jpg"
        elseif(tonumber(os.date('%H')) > 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120007200.jpg"
        end
    else
        url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
        text = "你输入的时长不正确\n!预报 [24/48/72] （缺省24）"
    end
else
    return 1
end
        luaRes =
              Api.Api_SendMsg(--调用发消息的接口
              CurrentQQ,
              {
                toUser = data.FromGroupId, --回复当前消息的来源群ID
                sendToType = 2, --2发送给群1发送给好友3私聊
                sendMsgType = "PicMsg", --进行文本复读回复
  				content = text,
  				picUrl = url,
  				picBase64Buf = "",
  				fileMd5 = ""
              }
          )
          Time=nil
          Hour=nil
          key=nil
          url=nil
          text=nil
        return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end