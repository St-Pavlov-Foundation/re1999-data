-- chunkname: @modules/configs/excel2json/lua_arcade_difficulty.lua

module("modules.configs.excel2json.lua_arcade_difficulty", package.seeall)

local lua_arcade_difficulty = {}
local fields = {
	addSkill = 3,
	characterTurnTime = 4,
	scope = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_difficulty, "configList", _configList)
	rawset(lua_arcade_difficulty, "configDict", _configDict)
end

setmetatable(lua_arcade_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_difficulty, "configList", nil)
	rawset(lua_arcade_difficulty, "configDict", nil)
end

return lua_arcade_difficulty
