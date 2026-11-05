-- chunkname: @modules/configs/excel2json/lua_odyssey_equip_suit.lua

module("modules.configs.excel2json.lua_odyssey_equip_suit", package.seeall)

local lua_odyssey_equip_suit = {}
local fields = {
	id = 1,
	name = 2,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_equip_suit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_equip_suit, "configList", _configList)
	rawset(lua_odyssey_equip_suit, "configDict", _configDict)
end

setmetatable(lua_odyssey_equip_suit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_equip_suit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_equip_suit, "configList", nil)
	rawset(lua_odyssey_equip_suit, "configDict", nil)
end

return lua_odyssey_equip_suit
