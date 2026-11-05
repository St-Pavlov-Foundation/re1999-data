-- chunkname: @modules/configs/excel2json/lua_arcade_skill_target.lua

module("modules.configs.excel2json.lua_arcade_skill_target", package.seeall)

local lua_arcade_skill_target = {}
local fields = {
	ignoreSelf = 4,
	effect = 5,
	targets = 3,
	clztype = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_skill_target_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_skill_target, "configList", _configList)
	rawset(lua_arcade_skill_target, "configDict", _configDict)
end

setmetatable(lua_arcade_skill_target, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_skill_target.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_skill_target, "configList", nil)
	rawset(lua_arcade_skill_target, "configDict", nil)
end

return lua_arcade_skill_target
