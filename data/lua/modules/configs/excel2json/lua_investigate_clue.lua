-- chunkname: @modules/configs/excel2json/lua_investigate_clue.lua

module("modules.configs.excel2json.lua_investigate_clue", package.seeall)

local lua_investigate_clue = {}
local fields = {
	mapRes = 5,
	relatedDesc = 9,
	infoID = 4,
	res = 6,
	mapElement = 3,
	id = 1,
	mapResLocked = 7,
	detailedDesc = 8,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detailedDesc = 1,
	relatedDesc = 2
}
local _configList, _configDict
local configPath = "configs.investigate_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_investigate_clue, "configList", _configList)
	rawset(lua_investigate_clue, "configDict", _configDict)
end

setmetatable(lua_investigate_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_investigate_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_investigate_clue, "configList", nil)
	rawset(lua_investigate_clue, "configDict", nil)
end

return lua_investigate_clue
