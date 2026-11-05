-- chunkname: @modules/configs/excel2json/lua_activity142_interact_object.lua

module("modules.configs.excel2json.lua_activity142_interact_object", package.seeall)

local lua_activity142_interact_object = {}
local fields = {
	alertType = 8,
	name = 3,
	id = 2,
	effectId = 10,
	moveAudioId = 12,
	param = 5,
	showParam = 7,
	createAudioId = 11,
	alertParam = 9,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity142_interact_object_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_interact_object, "configList", _configList)
	rawset(lua_activity142_interact_object, "configDict", _configDict)
end

setmetatable(lua_activity142_interact_object, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_interact_object.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_interact_object, "configList", nil)
	rawset(lua_activity142_interact_object, "configDict", nil)
end

return lua_activity142_interact_object
