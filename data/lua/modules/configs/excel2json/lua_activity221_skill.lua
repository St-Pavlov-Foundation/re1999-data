-- chunkname: @modules/configs/excel2json/lua_activity221_skill.lua

module("modules.configs.excel2json.lua_activity221_skill", package.seeall)

local lua_activity221_skill = {}
local fields = {
	effects = 5,
	skillID = 1,
	skilldesc = 4,
	cd = 6,
	skillType = 2,
	condition = 3
}
local primaryKey = {
	"skillID"
}
local mlStringKey = {
	skilldesc = 1
}
local _configList, _configDict
local configPath = "configs.activity221_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity221_skill, "configList", _configList)
	rawset(lua_activity221_skill, "configDict", _configDict)
end

setmetatable(lua_activity221_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity221_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity221_skill, "configList", nil)
	rawset(lua_activity221_skill, "configDict", nil)
end

return lua_activity221_skill
