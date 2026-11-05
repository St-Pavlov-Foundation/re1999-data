-- chunkname: @modules/configs/excel2json/lua_activity244_monster_template.lua

module("modules.configs.excel2json.lua_activity244_monster_template", package.seeall)

local lua_activity244_monster_template = {}
local fields = {
	defense = 4,
	id = 1,
	hp = 2,
	heal = 5,
	attack = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_monster_template_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_monster_template, "configList", _configList)
	rawset(lua_activity244_monster_template, "configDict", _configDict)
end

setmetatable(lua_activity244_monster_template, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_monster_template.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_monster_template, "configList", nil)
	rawset(lua_activity244_monster_template, "configDict", nil)
end

return lua_activity244_monster_template
