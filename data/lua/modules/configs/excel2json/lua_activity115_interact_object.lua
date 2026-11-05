-- chunkname: @modules/configs/excel2json/lua_activity115_interact_object.lua

module("modules.configs.excel2json.lua_activity115_interact_object", package.seeall)

local lua_activity115_interact_object = {}
local fields = {
	alertType = 8,
	name = 3,
	id = 2,
	param = 5,
	battleDesc = 11,
	alertParam = 9,
	showParam = 7,
	battleName = 10,
	recommendLevel = 12,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	battleDesc = 3,
	name = 1,
	battleName = 2
}
local _configList, _configDict
local configPath = "configs.activity115_interact_object_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_interact_object, "configList", _configList)
	rawset(lua_activity115_interact_object, "configDict", _configDict)
end

setmetatable(lua_activity115_interact_object, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_interact_object.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_interact_object, "configList", nil)
	rawset(lua_activity115_interact_object, "configDict", nil)
end

return lua_activity115_interact_object
