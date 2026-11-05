-- chunkname: @modules/configs/excel2json/lua_turnback_drop.lua

module("modules.configs.excel2json.lua_turnback_drop", package.seeall)

local lua_turnback_drop = {}
local fields = {
	listenerParam = 5,
	name = 3,
	showTxt = 8,
	type = 4,
	id = 1,
	picPath = 7,
	jumpId = 6,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	showTxt = 1
}
local _configList, _configDict
local configPath = "configs.turnback_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_drop, "configList", _configList)
	rawset(lua_turnback_drop, "configDict", _configDict)
end

setmetatable(lua_turnback_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_drop, "configList", nil)
	rawset(lua_turnback_drop, "configDict", nil)
end

return lua_turnback_drop
