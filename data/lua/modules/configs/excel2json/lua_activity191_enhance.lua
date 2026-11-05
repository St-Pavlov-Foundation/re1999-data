-- chunkname: @modules/configs/excel2json/lua_activity191_enhance.lua

module("modules.configs.excel2json.lua_activity191_enhance", package.seeall)

local lua_activity191_enhance = {}
local fields = {
	relate = 8,
	name = 4,
	relateItem = 7,
	icon = 9,
	weight = 11,
	desc = 5,
	effects = 10,
	relateHero = 6,
	id = 1,
	stage = 3,
	activityId = 2
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity191_enhance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_enhance, "configList", _configList)
	rawset(lua_activity191_enhance, "configDict", _configDict)
end

setmetatable(lua_activity191_enhance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_enhance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_enhance, "configList", nil)
	rawset(lua_activity191_enhance, "configDict", nil)
end

return lua_activity191_enhance
