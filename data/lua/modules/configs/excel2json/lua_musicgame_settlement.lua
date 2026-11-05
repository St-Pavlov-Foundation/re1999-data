-- chunkname: @modules/configs/excel2json/lua_musicgame_settlement.lua

module("modules.configs.excel2json.lua_musicgame_settlement", package.seeall)

local lua_musicgame_settlement = {}
local fields = {
	id = 1,
	audioId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.musicgame_settlement_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_musicgame_settlement, "configList", _configList)
	rawset(lua_musicgame_settlement, "configDict", _configDict)
end

setmetatable(lua_musicgame_settlement, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_musicgame_settlement.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_musicgame_settlement, "configList", nil)
	rawset(lua_musicgame_settlement, "configDict", nil)
end

return lua_musicgame_settlement
