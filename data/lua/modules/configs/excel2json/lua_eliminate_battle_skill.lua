-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_skill.lua

module("modules.configs.excel2json.lua_eliminate_battle_skill", package.seeall)

local lua_eliminate_battle_skill = {}
local fields = {
	triggerPoint = 7,
	name = 2,
	cd = 6,
	type = 4,
	effect = 9,
	condition = 8,
	desc = 3,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	type = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.eliminate_battle_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_skill, "configList", _configList)
	rawset(lua_eliminate_battle_skill, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_skill, "configList", nil)
	rawset(lua_eliminate_battle_skill, "configDict", nil)
end

return lua_eliminate_battle_skill
