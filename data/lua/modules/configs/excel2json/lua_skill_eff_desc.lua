-- chunkname: @modules/configs/excel2json/lua_skill_eff_desc.lua

module("modules.configs.excel2json.lua_skill_eff_desc", package.seeall)

local lua_skill_eff_desc = {}
local fields = {
	id = 1,
	name = 2,
	notAddLink = 4,
	isSpecialCharacter = 5,
	color = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.skill_eff_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_eff_desc, "configList", _configList)
	rawset(lua_skill_eff_desc, "configDict", _configDict)
end

setmetatable(lua_skill_eff_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_eff_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_eff_desc, "configList", nil)
	rawset(lua_skill_eff_desc, "configDict", nil)
end

return lua_skill_eff_desc
