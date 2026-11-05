-- chunkname: @modules/configs/excel2json/lua_college_skill.lua

module("modules.configs.excel2json.lua_college_skill", package.seeall)

local lua_college_skill = {}
local fields = {
	id = 1,
	name = 2,
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
local configPath = "configs.college_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_skill, "configList", _configList)
	rawset(lua_college_skill, "configDict", _configDict)
end

setmetatable(lua_college_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_skill, "configList", nil)
	rawset(lua_college_skill, "configDict", nil)
end

return lua_college_skill
