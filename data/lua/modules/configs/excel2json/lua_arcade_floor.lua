-- chunkname: @modules/configs/excel2json/lua_arcade_floor.lua

module("modules.configs.excel2json.lua_arcade_floor", package.seeall)

local lua_arcade_floor = {}
local fields = {
	scale = 7,
	name = 2,
	priority = 9,
	icon = 11,
	limitRound = 12,
	desc = 3,
	posOffset = 8,
	skill = 4,
	category = 10,
	id = 1,
	shape = 6,
	resPath = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_floor_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_floor, "configList", _configList)
	rawset(lua_arcade_floor, "configDict", _configDict)
end

setmetatable(lua_arcade_floor, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_floor.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_floor, "configList", nil)
	rawset(lua_arcade_floor, "configDict", nil)
end

return lua_arcade_floor
