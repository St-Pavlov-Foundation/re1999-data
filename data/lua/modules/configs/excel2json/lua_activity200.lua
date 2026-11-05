-- chunkname: @modules/configs/excel2json/lua_activity200.lua

module("modules.configs.excel2json.lua_activity200", package.seeall)

local lua_activity200 = {}
local fields = {
	photo2 = 9,
	name = 4,
	preId = 3,
	photo1 = 8,
	text = 5,
	id = 2,
	position = 7,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity200_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity200, "configList", _configList)
	rawset(lua_activity200, "configDict", _configDict)
end

setmetatable(lua_activity200, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity200.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity200, "configList", nil)
	rawset(lua_activity200, "configDict", nil)
end

return lua_activity200
