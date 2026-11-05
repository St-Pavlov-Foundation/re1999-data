-- chunkname: @modules/configs/excel2json/lua_activity146.lua

module("modules.configs.excel2json.lua_activity146", package.seeall)

local lua_activity146 = {}
local fields = {
	openDay = 4,
	name = 5,
	preId = 3,
	interactType = 9,
	text = 6,
	photo = 8,
	id = 2,
	activityId = 1,
	bonus = 7
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
local configPath = "configs.activity146_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity146, "configList", _configList)
	rawset(lua_activity146, "configDict", _configDict)
end

setmetatable(lua_activity146, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity146.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity146, "configList", nil)
	rawset(lua_activity146, "configDict", nil)
end

return lua_activity146
