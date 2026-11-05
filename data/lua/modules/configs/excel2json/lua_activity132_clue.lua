-- chunkname: @modules/configs/excel2json/lua_activity132_clue.lua

module("modules.configs.excel2json.lua_activity132_clue", package.seeall)

local lua_activity132_clue = {}
local fields = {
	contents = 4,
	name = 3,
	pos = 5,
	clueId = 2,
	smallBg = 6,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"clueId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity132_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity132_clue, "configList", _configList)
	rawset(lua_activity132_clue, "configDict", _configDict)
end

setmetatable(lua_activity132_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity132_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity132_clue, "configList", nil)
	rawset(lua_activity132_clue, "configDict", nil)
end

return lua_activity132_clue
