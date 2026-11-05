-- chunkname: @modules/configs/excel2json/lua_rogue_field.lua

module("modules.configs.excel2json.lua_rogue_field", package.seeall)

local lua_rogue_field = {}
local fields = {
	cost = 2,
	equipLevel = 6,
	level6 = 5,
	level4 = 3,
	level5 = 4,
	talentLevel = 7,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_field_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_field, "configList", _configList)
	rawset(lua_rogue_field, "configDict", _configDict)
end

setmetatable(lua_rogue_field, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_field.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_field, "configList", nil)
	rawset(lua_rogue_field, "configDict", nil)
end

return lua_rogue_field
