-- chunkname: @modules/configs/excel2json/lua_activity193_dicepool.lua

module("modules.configs.excel2json.lua_activity193_dicepool", package.seeall)

local lua_activity193_dicepool = {}
local fields = {
	dicePoints = 2,
	name = 4,
	winDice = 3,
	id = 1,
	weight = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity193_dicepool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity193_dicepool, "configList", _configList)
	rawset(lua_activity193_dicepool, "configDict", _configDict)
end

setmetatable(lua_activity193_dicepool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity193_dicepool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity193_dicepool, "configList", nil)
	rawset(lua_activity193_dicepool, "configDict", nil)
end

return lua_activity193_dicepool
