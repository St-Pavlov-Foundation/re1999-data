-- chunkname: @modules/configs/excel2json/lua_trade_level_unlock.lua

module("modules.configs.excel2json.lua_trade_level_unlock", package.seeall)

local lua_trade_level_unlock = {}
local fields = {
	itemType = 7,
	name = 2,
	levelupDes = 5,
	type = 4,
	id = 1,
	icon = 3,
	sort = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	levelupDes = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.trade_level_unlock_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trade_level_unlock, "configList", _configList)
	rawset(lua_trade_level_unlock, "configDict", _configDict)
end

setmetatable(lua_trade_level_unlock, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trade_level_unlock.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trade_level_unlock, "configList", nil)
	rawset(lua_trade_level_unlock, "configDict", nil)
end

return lua_trade_level_unlock
