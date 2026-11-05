-- chunkname: @modules/configs/excel2json/lua_activity115_skill.lua

module("modules.configs.excel2json.lua_activity115_skill", package.seeall)

local lua_activity115_skill = {}
local fields = {
	param = 4,
	name = 6,
	type = 3,
	id = 2,
	canUseCount = 5,
	activityId = 1,
	desc = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity115_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_skill, "configList", _configList)
	rawset(lua_activity115_skill, "configDict", _configDict)
end

setmetatable(lua_activity115_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_skill, "configList", nil)
	rawset(lua_activity115_skill, "configDict", nil)
end

return lua_activity115_skill
