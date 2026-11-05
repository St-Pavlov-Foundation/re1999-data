-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_skill.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_skill", package.seeall)

local lua_weekwalk_ver2_skill = {}
local fields = {
	rules = 5,
	name = 2,
	id = 1,
	icon = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2_skill, "configList", _configList)
	rawset(lua_weekwalk_ver2_skill, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2_skill, "configList", nil)
	rawset(lua_weekwalk_ver2_skill, "configDict", nil)
end

return lua_weekwalk_ver2_skill
