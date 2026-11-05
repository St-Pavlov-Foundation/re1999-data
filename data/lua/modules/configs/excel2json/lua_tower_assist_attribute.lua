-- chunkname: @modules/configs/excel2json/lua_tower_assist_attribute.lua

module("modules.configs.excel2json.lua_tower_assist_attribute", package.seeall)

local lua_tower_assist_attribute = {}
local fields = {
	bossId = 1,
	criDmg = 5,
	hp = 6,
	cri = 4,
	attack = 3,
	teamLevel = 2
}
local primaryKey = {
	"bossId",
	"teamLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_assist_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_assist_attribute, "configList", _configList)
	rawset(lua_tower_assist_attribute, "configDict", _configDict)
end

setmetatable(lua_tower_assist_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_assist_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_assist_attribute, "configList", nil)
	rawset(lua_tower_assist_attribute, "configDict", nil)
end

return lua_tower_assist_attribute
