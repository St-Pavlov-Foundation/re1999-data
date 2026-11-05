-- chunkname: @modules/configs/excel2json/lua_activity104_equip.lua

module("modules.configs.excel2json.lua_activity104_equip", package.seeall)

local lua_activity104_equip = {}
local fields = {
	iconOffset = 7,
	name = 2,
	attrId = 9,
	signIcon = 6,
	isOptional = 4,
	career = 11,
	rare = 3,
	careerIcon = 12,
	equipId = 1,
	signOffset = 8,
	group = 13,
	skillId = 10,
	tag = 15,
	icon = 5,
	activityId = 14
}
local primaryKey = {
	"equipId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity104_equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_equip, "configList", _configList)
	rawset(lua_activity104_equip, "configDict", _configDict)
end

setmetatable(lua_activity104_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_equip, "configList", nil)
	rawset(lua_activity104_equip, "configDict", nil)
end

return lua_activity104_equip
