-- chunkname: @modules/configs/excel2json/lua_stance_hp_offset.lua

module("modules.configs.excel2json.lua_stance_hp_offset", package.seeall)

local lua_stance_hp_offset = {}
local fields = {
	offsetPos8 = 9,
	offsetPos4 = 5,
	offsetPos1 = 2,
	offsetPos7 = 8,
	offsetPos3 = 4,
	id = 1,
	offsetPos5 = 6,
	offsetPos6 = 7,
	offsetPos2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stance_hp_offset_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stance_hp_offset, "configList", _configList)
	rawset(lua_stance_hp_offset, "configDict", _configDict)
end

setmetatable(lua_stance_hp_offset, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stance_hp_offset.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stance_hp_offset, "configList", nil)
	rawset(lua_stance_hp_offset, "configDict", nil)
end

return lua_stance_hp_offset
