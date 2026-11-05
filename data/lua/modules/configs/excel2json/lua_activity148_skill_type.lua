-- chunkname: @modules/configs/excel2json/lua_activity148_skill_type.lua

module("modules.configs.excel2json.lua_activity148_skill_type", package.seeall)

local lua_activity148_skill_type = {}
local fields = {
	skillInfoDesc = 4,
	skillIcon = 5,
	skillValueDesc = 3,
	skillNameEn = 6,
	id = 1,
	skillName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillInfoDesc = 3,
	skillName = 1,
	skillValueDesc = 2,
	skillNameEn = 5,
	skillIcon = 4
}
local _configList, _configDict
local configPath = "configs.activity148_skill_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity148_skill_type, "configList", _configList)
	rawset(lua_activity148_skill_type, "configDict", _configDict)
end

setmetatable(lua_activity148_skill_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity148_skill_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity148_skill_type, "configList", nil)
	rawset(lua_activity148_skill_type, "configDict", nil)
end

return lua_activity148_skill_type
