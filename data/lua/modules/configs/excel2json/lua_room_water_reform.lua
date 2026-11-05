-- chunkname: @modules/configs/excel2json/lua_room_water_reform.lua

module("modules.configs.excel2json.lua_room_water_reform", package.seeall)

local lua_room_water_reform = {}
local fields = {
	itemId = 3,
	blockType = 1,
	blockId = 2
}
local primaryKey = {
	"blockType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_water_reform_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_water_reform, "configList", _configList)
	rawset(lua_room_water_reform, "configDict", _configDict)
end

setmetatable(lua_room_water_reform, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_water_reform.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_water_reform, "configList", nil)
	rawset(lua_room_water_reform, "configDict", nil)
end

return lua_room_water_reform
