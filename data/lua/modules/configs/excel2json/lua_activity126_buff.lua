-- chunkname: @modules/configs/excel2json/lua_activity126_buff.lua

module("modules.configs.excel2json.lua_activity126_buff", package.seeall)

local lua_activity126_buff = {}
local fields = {
	cost = 9,
	name = 4,
	dreamlandCard = 7,
	type = 3,
	taskId = 10,
	bigIcon = 12,
	desc = 5,
	preBuffId = 8,
	skillId = 6,
	id = 1,
	icon = 11,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity126_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity126_buff, "configList", _configList)
	rawset(lua_activity126_buff, "configDict", _configDict)
end

setmetatable(lua_activity126_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity126_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity126_buff, "configList", nil)
	rawset(lua_activity126_buff, "configDict", nil)
end

return lua_activity126_buff
