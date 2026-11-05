-- chunkname: @modules/configs/excel2json/lua_player_newspaper.lua

module("modules.configs.excel2json.lua_player_newspaper", package.seeall)

local lua_player_newspaper = {}
local fields = {
	name = 3,
	type = 2,
	id = 1,
	displayPriority = 5,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.player_newspaper_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_player_newspaper, "configList", _configList)
	rawset(lua_player_newspaper, "configDict", _configDict)
end

setmetatable(lua_player_newspaper, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_player_newspaper.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_player_newspaper, "configList", nil)
	rawset(lua_player_newspaper, "configDict", nil)
end

return lua_player_newspaper
