-- chunkname: @modules/configs/excel2json/lua_partygame_pedalingplaid.lua

module("modules.configs.excel2json.lua_partygame_pedalingplaid", package.seeall)

local lua_partygame_pedalingplaid = {}
local fields = {
	param = 5,
	playerNum = 2,
	maxNum = 6,
	type = 3,
	id = 1,
	duration = 7,
	interval = 8,
	assetId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_pedalingplaid_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_pedalingplaid, "configList", _configList)
	rawset(lua_partygame_pedalingplaid, "configDict", _configDict)
end

setmetatable(lua_partygame_pedalingplaid, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_pedalingplaid.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_pedalingplaid, "configList", nil)
	rawset(lua_partygame_pedalingplaid, "configDict", nil)
end

return lua_partygame_pedalingplaid
