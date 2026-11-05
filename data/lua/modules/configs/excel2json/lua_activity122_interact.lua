-- chunkname: @modules/configs/excel2json/lua_activity122_interact.lua

module("modules.configs.excel2json.lua_activity122_interact", package.seeall)

local lua_activity122_interact = {}
local fields = {
	param = 5,
	name = 3,
	id = 2,
	effectId = 8,
	moveAudioId = 10,
	createAudioId = 9,
	showParam = 7,
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
local configPath = "configs.activity122_interact_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity122_interact, "configList", _configList)
	rawset(lua_activity122_interact, "configDict", _configDict)
end

setmetatable(lua_activity122_interact, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity122_interact.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity122_interact, "configList", nil)
	rawset(lua_activity122_interact, "configDict", nil)
end

return lua_activity122_interact
