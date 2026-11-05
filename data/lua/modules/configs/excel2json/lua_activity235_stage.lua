-- chunkname: @modules/configs/excel2json/lua_activity235_stage.lua

module("modules.configs.excel2json.lua_activity235_stage", package.seeall)

local lua_activity235_stage = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity235_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity235_stage, "configList", _configList)
	rawset(lua_activity235_stage, "configDict", _configDict)
end

setmetatable(lua_activity235_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity235_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity235_stage, "configList", nil)
	rawset(lua_activity235_stage, "configDict", nil)
end

return lua_activity235_stage
