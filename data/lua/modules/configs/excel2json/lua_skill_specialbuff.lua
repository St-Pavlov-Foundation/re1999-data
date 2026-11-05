-- chunkname: @modules/configs/excel2json/lua_skill_specialbuff.lua

module("modules.configs.excel2json.lua_skill_specialbuff", package.seeall)

local lua_skill_specialbuff = {}
local fields = {
	id = 1,
	icon = 2,
	lv = 3,
	isSpecial = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_specialbuff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_specialbuff, "configList", _configList)
	rawset(lua_skill_specialbuff, "configDict", _configDict)
end

setmetatable(lua_skill_specialbuff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_specialbuff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_specialbuff, "configList", nil)
	rawset(lua_skill_specialbuff, "configDict", nil)
end

return lua_skill_specialbuff
