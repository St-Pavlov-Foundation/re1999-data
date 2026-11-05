-- chunkname: @modules/configs/excel2json/lua_fight_skin_special_behaviour.lua

module("modules.configs.excel2json.lua_fight_skin_special_behaviour", package.seeall)

local lua_fight_skin_special_behaviour = {}
local fields = {
	id = 1,
	freeze = 4,
	die = 3,
	hit = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skin_special_behaviour_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skin_special_behaviour, "configList", _configList)
	rawset(lua_fight_skin_special_behaviour, "configDict", _configDict)
end

setmetatable(lua_fight_skin_special_behaviour, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skin_special_behaviour.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skin_special_behaviour, "configList", nil)
	rawset(lua_fight_skin_special_behaviour, "configDict", nil)
end

return lua_fight_skin_special_behaviour
