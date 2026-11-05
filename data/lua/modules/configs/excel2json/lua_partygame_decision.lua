-- chunkname: @modules/configs/excel2json/lua_partygame_decision.lua

module("modules.configs.excel2json.lua_partygame_decision", package.seeall)

local lua_partygame_decision = {}
local fields = {
	pos3 = 4,
	pos1 = 3,
	pos7 = 6,
	pos5 = 5,
	id = 1,
	group = 2,
	pos9 = 7
}
local primaryKey = {
	"id",
	"group"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_decision_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_decision, "configList", _configList)
	rawset(lua_partygame_decision, "configDict", _configDict)
end

setmetatable(lua_partygame_decision, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_decision.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_decision, "configList", nil)
	rawset(lua_partygame_decision, "configDict", nil)
end

return lua_partygame_decision
