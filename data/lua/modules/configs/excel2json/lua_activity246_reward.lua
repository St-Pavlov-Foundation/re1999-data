-- chunkname: @modules/configs/excel2json/lua_activity246_reward.lua

module("modules.configs.excel2json.lua_activity246_reward", package.seeall)

local lua_activity246_reward = {}
local fields = {
	reward = 2,
	type = 4,
	area = 3,
	rewardId = 1
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {}

function lua_activity246_reward.onLoad(json)
	lua_activity246_reward.configList, lua_activity246_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity246_reward
