-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_cardtype.lua

module("modules.configs.excel2json.lua_partygame_carddrop_cardtype", package.seeall)

local lua_partygame_carddrop_cardtype = {}
local fields = {
	name = 2,
	loseIcon = 5,
	id = 1,
	icon = 3,
	selectedMask = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.partygame_carddrop_cardtype_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_carddrop_cardtype, "configList", _configList)
	rawset(lua_partygame_carddrop_cardtype, "configDict", _configDict)
end

setmetatable(lua_partygame_carddrop_cardtype, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_carddrop_cardtype.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_carddrop_cardtype, "configList", nil)
	rawset(lua_partygame_carddrop_cardtype, "configDict", nil)
end

return lua_partygame_carddrop_cardtype
