-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_stage.lua

module("modules.configs.excel2json.lua_arcade_survivor_stage", package.seeall)

local lua_arcade_survivor_stage = {}
local fields = {
	id = 1,
	levelIds = 4,
	sceneRes = 2,
	eventPool = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_stage, "configList", _configList)
	rawset(lua_arcade_survivor_stage, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_stage, "configList", nil)
	rawset(lua_arcade_survivor_stage, "configDict", nil)
end

return lua_arcade_survivor_stage
