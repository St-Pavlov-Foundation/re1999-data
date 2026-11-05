-- chunkname: @modules/configs/excel2json/lua_skill_role_mapping.lua

module("modules.configs.excel2json.lua_skill_role_mapping", package.seeall)

local lua_skill_role_mapping = {}
local fields = {
	heroId = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_role_mapping_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_role_mapping, "configList", _configList)
	rawset(lua_skill_role_mapping, "configDict", _configDict)
end

setmetatable(lua_skill_role_mapping, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_role_mapping.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_role_mapping, "configList", nil)
	rawset(lua_skill_role_mapping, "configDict", nil)
end

return lua_skill_role_mapping
