-- chunkname: @modules/configs/excel2json/lua_production_part.lua

module("modules.configs.excel2json.lua_production_part", package.seeall)

local lua_production_part = {}
local fields = {
	productionLines = 4,
	name = 2,
	audio = 6,
	cameraParam = 5,
	id = 1,
	changeAudio = 7,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.production_part_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_production_part, "configList", _configList)
	rawset(lua_production_part, "configDict", _configDict)
end

setmetatable(lua_production_part, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_production_part.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_production_part, "configList", nil)
	rawset(lua_production_part, "configDict", nil)
end

return lua_production_part
