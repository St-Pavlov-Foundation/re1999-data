-- chunkname: @modules/configs/excel2json/lua_sodache_skill.lua

module("modules.configs.excel2json.lua_sodache_skill", package.seeall)

local lua_sodache_skill = {}
local fields = {
	id = 1,
	name = 2,
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
local configPath = "configs.sodache_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_skill, "configList", _configList)
	rawset(lua_sodache_skill, "configDict", _configDict)
end

setmetatable(lua_sodache_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_skill, "configList", nil)
	rawset(lua_sodache_skill, "configDict", nil)
end

return lua_sodache_skill
