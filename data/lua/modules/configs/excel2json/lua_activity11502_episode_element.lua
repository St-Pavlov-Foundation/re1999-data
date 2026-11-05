-- chunkname: @modules/configs/excel2json/lua_activity11502_episode_element.lua

module("modules.configs.excel2json.lua_activity11502_episode_element", package.seeall)

local lua_activity11502_episode_element = {}
local fields = {
	id = 1,
	finishEffectOffsetPos = 3,
	finishEffect = 2,
	mapIds = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity11502_episode_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity11502_episode_element, "configList", _configList)
	rawset(lua_activity11502_episode_element, "configDict", _configDict)
end

setmetatable(lua_activity11502_episode_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity11502_episode_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity11502_episode_element, "configList", nil)
	rawset(lua_activity11502_episode_element, "configDict", nil)
end

return lua_activity11502_episode_element
