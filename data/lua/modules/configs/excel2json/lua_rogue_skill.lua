-- chunkname: @modules/configs/excel2json/lua_rogue_skill.lua

module("modules.configs.excel2json.lua_rogue_skill", package.seeall)

local lua_rogue_skill = {}
local fields = {
	num = 2,
	desc = 6,
	skills = 5,
	id = 1,
	icon = 3,
	attr = 4
}
local primaryKey = {
	"id",
	"num"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rogue_skill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_skill, "configList", _configList)
	rawset(lua_rogue_skill, "configDict", _configDict)
end

setmetatable(lua_rogue_skill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_skill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_skill, "configList", nil)
	rawset(lua_rogue_skill, "configDict", nil)
end

return lua_rogue_skill
