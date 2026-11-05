-- chunkname: @modules/configs/excel2json/lua_skill_target_type_define.lua

module("modules.configs.excel2json.lua_skill_target_type_define", package.seeall)

local lua_skill_target_type_define = {}
local fields = {
	logicTarget = 1,
	define = 2
}
local primaryKey = {
	"logicTarget"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_target_type_define_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_target_type_define, "configList", _configList)
	rawset(lua_skill_target_type_define, "configDict", _configDict)
end

setmetatable(lua_skill_target_type_define, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_target_type_define.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_target_type_define, "configList", nil)
	rawset(lua_skill_target_type_define, "configDict", nil)
end

return lua_skill_target_type_define
