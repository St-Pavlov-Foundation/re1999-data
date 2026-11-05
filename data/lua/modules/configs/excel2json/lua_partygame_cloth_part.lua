-- chunkname: @modules/configs/excel2json/lua_partygame_cloth_part.lua

module("modules.configs.excel2json.lua_partygame_cloth_part", package.seeall)

local lua_partygame_cloth_part = {}
local fields = {
	partRes = 6,
	name = 2,
	partId = 5,
	activityId = 8,
	suitId = 3,
	image = 7,
	rare = 4,
	clothId = 1
}
local primaryKey = {
	"clothId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_cloth_part_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_cloth_part, "configList", _configList)
	rawset(lua_partygame_cloth_part, "configDict", _configDict)
end

setmetatable(lua_partygame_cloth_part, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_cloth_part.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_cloth_part, "configList", nil)
	rawset(lua_partygame_cloth_part, "configDict", nil)
end

return lua_partygame_cloth_part
