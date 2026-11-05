-- chunkname: @modules/configs/excel2json/lua_musicgame_level.lua

module("modules.configs.excel2json.lua_musicgame_level", package.seeall)

local lua_musicgame_level = {}
local fields = {
	score = 2,
	strValue = 3,
	audioId = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	strValue = 1
}
local _configList, _configDict
local configPath = "configs.musicgame_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_musicgame_level, "configList", _configList)
	rawset(lua_musicgame_level, "configDict", _configDict)
end

setmetatable(lua_musicgame_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_musicgame_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_musicgame_level, "configList", nil)
	rawset(lua_musicgame_level, "configDict", nil)
end

return lua_musicgame_level
