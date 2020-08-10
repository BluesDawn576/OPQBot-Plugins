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
if (string.find(data.Content, "!一言") == 1 or string.find(data.Content, "！一言") == 1  or string.find(data.Content, "!hitokoto") == 1  or string.find(data.Content, "！hitokoto") == 1) then
    local text = nil
        response, error_message =
            http.request(
            "GET",
            "https://v1.hitokoto.cn/"
        )
        local hitokoto = response.body
		local a = json.decode(hitokoto)
		if(a.from_who == nil) then
		    from = "「" .. a.from .. "」"
		else
		    from = a.from_who .. "「" .. a.from .. "」"
		end
	    text = "『一言 hitokoto』\n" .. a.hitokoto .. "\n——" .. from
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
			text = nil
    end
        return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
