-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_skill.lua

module("modules.configs.excel2json.lua_arcade_survivor_skill", package.seeall)

local lua_arcade_survivor_skill = {}
local fields = {
	id = 1,
	name = 2,
	effectIds = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_skill, "configList", _configList)
	rawset(lua_arcade_survivor_skill, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_skill, "configList", nil)
	rawset(lua_arcade_survivor_skill, "configDict", nil)
end

return lua_arcade_survivor_skill
