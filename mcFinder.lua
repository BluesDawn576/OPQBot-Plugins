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
if (string.find(data.Content, "!mc") == 1 or string.find(data.Content, "！mc") == 1) then 
    if(string.find(data.Content, "!") == 1) then
        key = data.Content:gsub("!mc", "")
    elseif(string.find(data.Content, "！") == 1) then
        key = data.Content:gsub("！mc", "")
    end
    local text = nil
    if(key ~= "") then
        response, error_message =
            http.request(
            "GET",
            "https://api.bluesdawn.top/minecraft/server/api?host=" .. key --频率限制10秒20次
        )
        local mc = response.body
		local a = json.decode(mc)
		local _status = a.status
		if (_status == "Online") then
		    if(a.version.version == nil) then
		        ver = "未知"
		    else
		        ver = a.version.version
		    end
		    text = "状态：在线\n人数：" ..a.players.online.. "/" ..a.players.max.. "\nMOTD：" ..a.motd.clean.text.. "\n版本：" ..ver..  "\nPing：" ..a.queryinfo.processed.. ""
		else
		    text = "连接超时或离线\nConnection refused: no further information"
		end
	else
	    text = "你查了个寂寞\n!mc [欲查询的服务器地址]"
	end
            ApiRet =
                Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg", 
                    groupid = 0,
                    content = text,
                    atUser = 0
                }
            )
            mc = nil
	    a = nil
	    ver = nil
	    text = nil
	    _status = nil
    end
        return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
