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
    if data.Content == "!邦邦车站" or data.Content == "！邦邦车站" or data.Content == "!有车吗" or data.Content == "！有车吗" or data.Content == "!ycm" or data.Content == "！ycm" then
        response, error_message =
            http.request(
            "GET",
            "https://api.bandoristation.com/?function=query_room_number"
        )
        local bb = response.body
        local a6 = json.decode(bb)
        if a6.status == "success" then
            local count = table.getn(a6.response)
            local room = {}
            local time = os.time()
            for i=1,count,1 do
                room[i] = "["..time - math.floor(a6.response[i].time*0.001).."秒前] ("..a6.response[i].number..") "..a6.response[i].raw_message
            end
            local text = table.concat(room,"\n")
            if count ~= 0 then
                message = "当前邦邦车站有"..count.."辆车\n"..text
            else
                message = "myc"
            end
            
        else
            message = "错误："..a6.response
        end
        SetMessage(CurrentQQ,data,message,data.FromUserId)
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

function SetMessage(CurrentQQ,data,text,at)
    if at ~= 0 then
    luaMsg =
	    Api.Api_SendMsg(--调用发消息的接口
	    CurrentQQ,
	    {
	       toUser = data.FromGroupId, --回复当前消息的来源群ID
	       sendToType = 2, --2发送给群1发送给好友3私聊
	       sendMsgType = "TextMsg", --进行文本复读回复
	       groupid = 0, --不是私聊自然就为0咯
	       content = "[ATUSER("..at..")] "..text --回复内容
	    }
	)
	else
	luaMsg =
	    Api.Api_SendMsg(--调用发消息的接口
	    CurrentQQ,
	    {
	       toUser = data.FromGroupId, --回复当前消息的来源群ID
	       sendToType = 2, --2发送给群1发送给好友3私聊
	       sendMsgType = "TextMsg", --进行文本复读回复
	       groupid = 0, --不是私聊自然就为0咯
	       content = text --回复内容
	    }
	)   
	end
end