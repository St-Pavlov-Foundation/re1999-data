-- chunkname: @modules/configs/excel2json/lua_activity123_equip.lua

module("modules.configs.excel2json.lua_activity123_equip", package.seeall)

local lua_activity123_equip = {}
local fields = {
	isMain = 4,
	name = 2,
	teamLimit = 15,
	indexLimit = 17,
	decomposeGet = 18,
	composeCost = 19,
	scoreStage = 21,
	scoreTitle = 20,
	equipId = 1,
	signOffset = 9,
	scoreStageTitle = 22,
	skillId = 11,
	tag = 14,
	icon = 6,
	activityId = 13,
	packageId = 5,
	specialEffect = 16,
	attrId = 10,
	group = 12,
	rare = 3,
	signIcon = 7,
	iconOffset = 8
}
local primaryKey = {
	"equipId"
}
local mlStringKey = {
	scoreTitle = 2,
	name = 1,
	scoreStageTitle = 3
}
local _configList, _configDict
local configPath = "configs.activity123_equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_equip, "configList", _configList)
	rawset(lua_activity123_equip, "configDict", _configDict)
end

setmetatable(lua_activity123_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_equip, "configList", nil)
	rawset(lua_activity123_equip, "configDict", nil)
end

return lua_activity123_equip
