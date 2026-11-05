-- chunkname: @modules/configs/excel2json/lua_atomic_element.lua

module("modules.configs.excel2json.lua_atomic_element", package.seeall)

local lua_atomic_element = {}
local fields = {
	preId = 5,
	needFollow = 10,
	isPermanent = 12,
	type = 6,
	isEmergency = 13,
	unlockCondition = 4,
	pos = 8,
	warning = 14,
	dialog = 18,
	icon = 9,
	conditionType = 3,
	reward = 16,
	parm = 7,
	dataBase = 17,
	canDisappear = 11,
	mapId = 2,
	warningExpired = 15,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.atomic_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_element, "configList", _configList)
	rawset(lua_atomic_element, "configDict", _configDict)
end

setmetatable(lua_atomic_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_element, "configList", nil)
	rawset(lua_atomic_element, "configDict", nil)
end

return lua_atomic_element
