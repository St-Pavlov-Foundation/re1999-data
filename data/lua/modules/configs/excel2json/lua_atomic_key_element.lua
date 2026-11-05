-- chunkname: @modules/configs/excel2json/lua_atomic_key_element.lua

module("modules.configs.excel2json.lua_atomic_key_element", package.seeall)

local lua_atomic_key_element = {}
local fields = {
	preId = 4,
	doorIdList = 5,
	parm = 7,
	type = 6,
	needFollow = 10,
	unlockCondition = 3,
	pos = 8,
	desc = 12,
	title = 11,
	mapId = 2,
	canClick = 13,
	id = 1,
	icon = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_key_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_key_element, "configList", _configList)
	rawset(lua_atomic_key_element, "configDict", _configDict)
end

setmetatable(lua_atomic_key_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_key_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_key_element, "configList", nil)
	rawset(lua_atomic_key_element, "configDict", nil)
end

return lua_atomic_key_element
