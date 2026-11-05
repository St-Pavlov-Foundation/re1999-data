-- chunkname: @modules/configs/excel2json/lua_activity188_skill.lua

module("modules.configs.excel2json.lua_activity188_skill", package.seeall)

local lua_activity188_skill = {}
local fields = {
	param = 4,
	effect = 3,
	skillId = 2,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"skillId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity188_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_skill, "configList", _configList)
	rawset(lua_activity188_skill, "configDict", _configDict)
end

setmetatable(lua_activity188_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_skill, "configList", nil)
	rawset(lua_activity188_skill, "configDict", nil)
end

return lua_activity188_skill
