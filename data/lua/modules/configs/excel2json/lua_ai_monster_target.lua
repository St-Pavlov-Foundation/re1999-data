-- chunkname: @modules/configs/excel2json/lua_ai_monster_target.lua

module("modules.configs.excel2json.lua_ai_monster_target", package.seeall)

local lua_ai_monster_target = {}
local fields = {
	id = 1,
	targetNumber = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.ai_monster_target_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_ai_monster_target, "configList", _configList)
	rawset(lua_ai_monster_target, "configDict", _configDict)
end

setmetatable(lua_ai_monster_target, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_ai_monster_target.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_ai_monster_target, "configList", nil)
	rawset(lua_ai_monster_target, "configDict", nil)
end

return lua_ai_monster_target
