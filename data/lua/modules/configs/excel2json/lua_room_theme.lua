-- chunkname: @modules/configs/excel2json/lua_room_theme.lua

module("modules.configs.excel2json.lua_room_theme", package.seeall)

local lua_room_theme = {}
local fields = {
	collectionBonus = 8,
	name = 2,
	desc = 4,
	packages = 7,
	building = 6,
	sourcesType = 10,
	id = 1,
	extraShowBuilding = 9,
	rewardIcon = 5,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.room_theme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_theme, "configList", _configList)
	rawset(lua_room_theme, "configDict", _configDict)
end

setmetatable(lua_room_theme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_theme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_theme, "configList", nil)
	rawset(lua_room_theme, "configDict", nil)
end

return lua_room_theme
