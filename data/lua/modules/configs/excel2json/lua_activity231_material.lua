-- chunkname: @modules/configs/excel2json/lua_activity231_material.lua

module("modules.configs.excel2json.lua_activity231_material", package.seeall)

local lua_activity231_material = {}
local fields = {
	cost = 7,
	name = 5,
	advantage = 8,
	type = 3,
	id = 2,
	unlockCondition = 4,
	activityId = 1,
	icon = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity231_material_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_material, "configList", _configList)
	rawset(lua_activity231_material, "configDict", _configDict)
end

setmetatable(lua_activity231_material, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_material.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_material, "configList", nil)
	rawset(lua_activity231_material, "configDict", nil)
end

return lua_activity231_material
