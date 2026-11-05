-- chunkname: @modules/configs/excel2json/lua_racing_gift.lua

module("modules.configs.excel2json.lua_racing_gift", package.seeall)

local lua_racing_gift = {}
local fields = {
	cost = 11,
	name = 8,
	order = 5,
	shortDesc = 9,
	group = 4,
	effect = 6,
	desc = 10,
	gift_point = 1,
	icon = 7,
	activityId = 3,
	level = 2
}
local primaryKey = {
	"gift_point",
	"level"
}
local mlStringKey = {
	shortDesc = 2,
	name = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.racing_gift_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_gift, "configList", _configList)
	rawset(lua_racing_gift, "configDict", _configDict)
end

setmetatable(lua_racing_gift, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_gift.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_gift, "configList", nil)
	rawset(lua_racing_gift, "configDict", nil)
end

return lua_racing_gift
