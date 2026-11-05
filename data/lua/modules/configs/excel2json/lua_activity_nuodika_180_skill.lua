-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_skill.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_skill", package.seeall)

local lua_activity_nuodika_180_skill = {}
local fields = {
	param = 3,
	effect = 2,
	scale = 5,
	skillId = 1,
	trigger = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity_nuodika_180_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_nuodika_180_skill, "configList", _configList)
	rawset(lua_activity_nuodika_180_skill, "configDict", _configDict)
end

setmetatable(lua_activity_nuodika_180_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_nuodika_180_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_nuodika_180_skill, "configList", nil)
	rawset(lua_activity_nuodika_180_skill, "configDict", nil)
end

return lua_activity_nuodika_180_skill
