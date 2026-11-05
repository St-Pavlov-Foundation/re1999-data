-- chunkname: @modules/configs/excel2json/lua_activity144_equip.lua

module("modules.configs.excel2json.lua_activity144_equip", package.seeall)

local lua_activity144_equip = {}
local fields = {
	cost = 4,
	name = 8,
	buffId = 6,
	preEquipId = 3,
	typeId = 7,
	equipId = 2,
	effectDesc = 9,
	activityId = 1,
	level = 5
}
local primaryKey = {
	"activityId",
	"equipId"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity144_equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_equip, "configList", _configList)
	rawset(lua_activity144_equip, "configDict", _configDict)
end

setmetatable(lua_activity144_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_equip, "configList", nil)
	rawset(lua_activity144_equip, "configDict", nil)
end

return lua_activity144_equip
