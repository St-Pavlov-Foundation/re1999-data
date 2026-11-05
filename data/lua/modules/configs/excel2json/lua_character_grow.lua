-- chunkname: @modules/configs/excel2json/lua_character_grow.lua

module("modules.configs.excel2json.lua_character_grow", package.seeall)

local lua_character_grow = {}
local fields = {
	technic = 7,
	def = 5,
	hp = 3,
	atk = 4,
	id = 1,
	icon = 2,
	mdef = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_grow_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_grow, "configList", _configList)
	rawset(lua_character_grow, "configDict", _configDict)
end

setmetatable(lua_character_grow, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_grow.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_grow, "configList", nil)
	rawset(lua_character_grow, "configDict", nil)
end

return lua_character_grow
