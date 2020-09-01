--BluesDawn
local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUin ==2126622797 then--防止自我复读
		  return 1 end
		  
if (string.find(data.Content, "!云图") == 1 or string.find(data.Content, "！云图") == 1) then
    if data.Content == "!云图" or data.Content == "！云图" then
        url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
        text = "『BDbot』现已支持的云图\n风云二号全国云图: !云图 fy2\n风云二号西北太平洋云图: !云图 fy2f\n风云四号全国云图: !云图 fy4a\n风云四号全圆盘云图: !云图\n最新台风特写：!云图 台风"
    elseif data.Content == "!云图 fy2" or data.Content == "！云图 fy2" or data.Content == "!云图fy2" then
        Time = os.date('!%Y%m%d')
        Hour = os.date('!%H')
        if(tonumber(os.date('!%M')) < 30) then
            Hour = string.format("%02d",Hour - 1)
        end
        
        if(tonumber(os.date('%H')) == 1 and tonumber(os.date('%H')) == 2) then
            Hour = "16"
        end
        --url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nsmc_wxcl_asc_e99_achn_lno_py_" ..Time..Hour.. "1500000.jpg" --中国天气源
        url = "http://img.nsmc.org.cn/CLOUDIMAGE/FY2/WXCL/SEVP_NSMC_WXCL_ASC_E99_ACHN_LNO_PY_" ..Time..Hour.. "1500000.jpg" --中国气象局源
        text = ""
    elseif data.Content == "!云图 fy2f" or data.Content == "！云图 fy2f" or data.Content == "!云图fy2f" then
        url = "http://img.nsmc.org.cn/CLOUDIMAGE/FY2F/REG/FY2F_SEC_IR1_PA5_YYYYMMDD_HHmm.jpg" --国家卫星气象中心源
        text = ""
    elseif data.Content == "!云图 fy4a" or data.Content == "！云图 fy4a" or data.Content == "!云图fy4a" then
        url = "http://img.nsmc.org.cn/CLOUDIMAGE/FY4A/MTCC/FY4A_CHINA.JPG" --国家卫星气象中心源
        text = ""
    elseif data.Content == "!云图 fy4af" or data.Content == "！云图 fy4af" or data.Content == "!云图fy4af" then
        url = "http://img.nsmc.org.cn/CLOUDIMAGE/FY4A/MTCC/FY4A_DISK.JPG" --国家卫星气象中心源
        text = ""
    elseif data.Content == "!云图 台风" or data.Content == "！云图 台风" or data.Content == "!云图台风" then
        url = "https://weather-models.info/latest/nocache/himawari/target/vis0.png" --WeatherModels源
        text = ""
    else
        url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
        text = "『BDbot』没有此类云图"
    end
elseif (string.find(data.Content, "!预报") == 1 or string.find(data.Content, "！预报") == 1) then
    if(string.find(data.Content, "!") == 1) then
        key = data.Content:gsub("!预报", "")
    elseif(string.find(data.Content, "！") == 1) then
        key = data.Content:gsub("！预报", "")
    end
    Time = os.date('%Y%m%d')
    text = ""
    if(key == "24" or key == " 24" or key == "") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "『BDbot』今日还没有24小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 10) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000002400.jpg"
        elseif(tonumber(os.date('%H')) > 10 and tonumber(os.date('%H')) <= 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "060002400.jpg"
        elseif(tonumber(os.date('%H')) > 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120002400.jpg"
        end
    elseif(key == "48" or key == " 48") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "『BDbot』今日还没有48小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000004800.jpg"
        elseif(tonumber(os.date('%H')) > 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120004800.jpg"
        end
    elseif(key == "72" or key == " 72") then
        if(tonumber(os.date('%H')) >= 0 and tonumber(os.date('%H')) <= 6) then
            url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
            text = "『BDbot』今日还没有72小时降水量预报图，请7点后再试"
        elseif(tonumber(os.date('%H')) > 6 and tonumber(os.date('%H')) <= 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "000007200.jpg"
        elseif(tonumber(os.date('%H')) > 18) then
            url = "http://pi.weather.com.cn/i/product/pic/l/sevp_nmc_stfc_sfer_er24_achn_l88_p9_" ..Time.. "120007200.jpg"
        end
    else
        url = "https://i.tq121.com.cn/i/weather2015/index/tianqiyubao.png"
        text = "『BDbot』你输入的时长不正确\n!预报 [24/48/72] （缺省24）"
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