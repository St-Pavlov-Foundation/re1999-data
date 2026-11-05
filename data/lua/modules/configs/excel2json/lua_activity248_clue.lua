-- chunkname: @modules/configs/excel2json/lua_activity248_clue.lua

module("modules.configs.excel2json.lua_activity248_clue", package.seeall)

local lua_activity248_clue = {}
local fields = {
	tabIcon = 5,
	name = 7,
	param = 10,
	type = 9,
	coverId = 11,
	pic = 6,
	desc = 8,
	caseId = 3,
	category = 2,
	id = 1,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity248_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity248_clue, "configList", _configList)
	rawset(lua_activity248_clue, "configDict", _configDict)
end

setmetatable(lua_activity248_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity248_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity248_clue, "configList", nil)
	rawset(lua_activity248_clue, "configDict", nil)
end

return lua_activity248_clue
