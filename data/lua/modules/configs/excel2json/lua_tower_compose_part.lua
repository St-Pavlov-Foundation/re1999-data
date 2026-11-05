-- chunkname: @modules/configs/excel2json/lua_tower_compose_part.lua

module("modules.configs.excel2json.lua_tower_compose_part", package.seeall)

local lua_tower_compose_part = {}
local fields = {
	bossId = 2,
	partLevel = 10,
	partDesc = 11,
	isUnlock = 12,
	bossPointBase = 4,
	slotPart = 9,
	partName = 7,
	slot = 3,
	partEffects = 6,
	id = 1,
	icon = 8,
	bossPointAdd = 5
}
local primaryKey = {
	"id",
	"bossId"
}
local mlStringKey = {
	partName = 1,
	partDesc = 2
}
local _configList, _configDict
local configPath = "configs.tower_compose_part_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_part, "configList", _configList)
	rawset(lua_tower_compose_part, "configDict", _configDict)
end

setmetatable(lua_tower_compose_part, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_part.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_part, "configList", nil)
	rawset(lua_tower_compose_part, "configDict", nil)
end

return lua_tower_compose_part
