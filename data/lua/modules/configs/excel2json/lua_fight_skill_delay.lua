-- chunkname: @modules/configs/excel2json/lua_fight_skill_delay.lua

module("modules.configs.excel2json.lua_fight_skill_delay", package.seeall)

local lua_fight_skill_delay = {}
local fields = {
	id = 1,
	delay = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skill_delay_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skill_delay, "configList", _configList)
	rawset(lua_fight_skill_delay, "configDict", _configDict)
end

setmetatable(lua_fight_skill_delay, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skill_delay.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skill_delay, "configList", nil)
	rawset(lua_fight_skill_delay, "configDict", nil)
end

return lua_fight_skill_delay
