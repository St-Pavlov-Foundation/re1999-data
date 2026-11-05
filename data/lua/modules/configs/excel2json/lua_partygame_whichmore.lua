-- chunkname: @modules/configs/excel2json/lua_partygame_whichmore.lua

module("modules.configs.excel2json.lua_partygame_whichmore", package.seeall)

local lua_partygame_whichmore = {}
local fields = {
	othersFlip = 5,
	picture = 2,
	pictureNumber = 3,
	id = 1,
	firstFlip = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_whichmore_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_whichmore, "configList", _configList)
	rawset(lua_partygame_whichmore, "configDict", _configDict)
end

setmetatable(lua_partygame_whichmore, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_whichmore.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_whichmore, "configList", nil)
	rawset(lua_partygame_whichmore, "configDict", nil)
end

return lua_partygame_whichmore
