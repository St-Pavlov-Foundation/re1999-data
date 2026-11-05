-- chunkname: @modules/configs/excel2json/lua_udimo_background_area.lua

module("modules.configs.excel2json.lua_udimo_background_area", package.seeall)

local lua_udimo_background_area = {}
local fields = {
	groupId = 2,
	xMoveRange = 5,
	id = 1,
	yLevel = 4,
	zLevel = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_background_area_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_background_area, "configList", _configList)
	rawset(lua_udimo_background_area, "configDict", _configDict)
end

setmetatable(lua_udimo_background_area, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_background_area.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_background_area, "configList", nil)
	rawset(lua_udimo_background_area, "configDict", nil)
end

return lua_udimo_background_area
