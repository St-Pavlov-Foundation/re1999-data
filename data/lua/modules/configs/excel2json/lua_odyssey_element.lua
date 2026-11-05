-- chunkname: @modules/configs/excel2json/lua_odyssey_element.lua

module("modules.configs.excel2json.lua_odyssey_element", package.seeall)

local lua_odyssey_element = {}
local fields = {
	type = 4,
	iconFrame = 7,
	refreshType = 11,
	main = 8,
	needFollow = 10,
	unlockCondition = 3,
	pos = 5,
	taskDesc = 9,
	isPermanent = 12,
	mapId = 2,
	heroPos = 13,
	dataBase = 14,
	id = 1,
	icon = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDesc = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_element, "configList", _configList)
	rawset(lua_odyssey_element, "configDict", _configDict)
end

setmetatable(lua_odyssey_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_element, "configList", nil)
	rawset(lua_odyssey_element, "configDict", nil)
end

return lua_odyssey_element
