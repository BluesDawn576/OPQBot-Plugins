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
    if(string.find(data.Content, "!") == 1) then
        rowkey = data.Content:gsub("!", "")
    elseif(string.find(data.Content, "！") == 1) then
        rowkey = data.Content:gsub("！", "")
    else
        return 1
    end
    if(string.find(rowkey, "还是") ~= 0) then
        key = string.split(rowkey, "还是")
        text = key[math.random(table.getn(key))]
    elseif(string.find(rowkey, " or ") ~= 0) then
        key = string.split(rowkey, " or ")
        text = key[math.random(table.getn(key))]
    end
    if(text ~= nil) then
        msg = "建议你选择：" .. text .. ""
	else
	    msg = "找不到选择项\n![选项1]还是[选项2]"
	end
        ApiRet =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg", 
                groupid = 0,
                content = msg,
                atUser = 0
            }
        )
        msg = nil
		text = nil
        return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end

function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end