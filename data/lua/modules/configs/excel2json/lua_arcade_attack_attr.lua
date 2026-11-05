-- chunkname: @modules/configs/excel2json/lua_arcade_attack_attr.lua

module("modules.configs.excel2json.lua_arcade_attack_attr", package.seeall)

local lua_arcade_attack_attr = {}
local fields = {
	id = 1,
	name = 2,
	hitActionShow = 3,
	skills = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_attack_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_attack_attr, "configList", _configList)
	rawset(lua_arcade_attack_attr, "configDict", _configDict)
end

setmetatable(lua_arcade_attack_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_attack_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_attack_attr, "configList", nil)
	rawset(lua_arcade_attack_attr, "configDict", nil)
end

return lua_arcade_attack_attr
