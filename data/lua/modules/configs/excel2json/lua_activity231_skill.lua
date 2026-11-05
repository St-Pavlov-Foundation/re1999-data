-- chunkname: @modules/configs/excel2json/lua_activity231_skill.lua

module("modules.configs.excel2json.lua_activity231_skill", package.seeall)

local lua_activity231_skill = {}
local fields = {
	effectIds = 7,
	name = 2,
	cd = 6,
	type = 5,
	id = 1,
	icon = 4,
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
local configPath = "configs.activity231_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_skill, "configList", _configList)
	rawset(lua_activity231_skill, "configDict", _configDict)
end

setmetatable(lua_activity231_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_skill, "configList", nil)
	rawset(lua_activity231_skill, "configDict", nil)
end

return lua_activity231_skill
