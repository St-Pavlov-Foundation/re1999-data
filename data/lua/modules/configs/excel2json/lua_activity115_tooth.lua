-- chunkname: @modules/configs/excel2json/lua_activity115_tooth.lua

module("modules.configs.excel2json.lua_activity115_tooth", package.seeall)

local lua_activity115_tooth = {}
local fields = {
	story = 5,
	name = 3,
	prefab = 7,
	id = 2,
	icon = 6,
	activityId = 1,
	desc = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity115_tooth_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_tooth, "configList", _configList)
	rawset(lua_activity115_tooth, "configDict", _configDict)
end

setmetatable(lua_activity115_tooth, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_tooth.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_tooth, "configList", nil)
	rawset(lua_activity115_tooth, "configDict", nil)
end

return lua_activity115_tooth
