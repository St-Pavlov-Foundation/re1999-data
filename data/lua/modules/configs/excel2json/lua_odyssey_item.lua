-- chunkname: @modules/configs/excel2json/lua_odyssey_item.lua

module("modules.configs.excel2json.lua_odyssey_item", package.seeall)

local lua_odyssey_item = {}
local fields = {
	suitId = 8,
	name = 4,
	addSkill = 9,
	type = 3,
	extraSuitCount = 10,
	rare = 2,
	desc = 5,
	id = 1,
	icon = 7,
	skillDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.odyssey_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_item, "configList", _configList)
	rawset(lua_odyssey_item, "configDict", _configDict)
end

setmetatable(lua_odyssey_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_item, "configList", nil)
	rawset(lua_odyssey_item, "configDict", nil)
end

return lua_odyssey_item
