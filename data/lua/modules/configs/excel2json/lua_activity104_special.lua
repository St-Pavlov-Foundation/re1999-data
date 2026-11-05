-- chunkname: @modules/configs/excel2json/lua_activity104_special.lua

module("modules.configs.excel2json.lua_activity104_special", package.seeall)

local lua_activity104_special = {}
local fields = {
	openDay = 9,
	name = 4,
	episodeId = 3,
	nameen = 5,
	level = 7,
	desc = 8,
	icon = 6,
	activityId = 1,
	layer = 2
}
local primaryKey = {
	"activityId",
	"layer"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity104_special_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_special, "configList", _configList)
	rawset(lua_activity104_special, "configDict", _configDict)
end

setmetatable(lua_activity104_special, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_special.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_special, "configList", nil)
	rawset(lua_activity104_special, "configDict", nil)
end

return lua_activity104_special
