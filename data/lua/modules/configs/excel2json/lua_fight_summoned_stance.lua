-- chunkname: @modules/configs/excel2json/lua_fight_summoned_stance.lua

module("modules.configs.excel2json.lua_fight_summoned_stance", package.seeall)

local lua_fight_summoned_stance = {}
local fields = {
	pos3 = 4,
	pos1 = 2,
	pos2 = 3,
	id = 1,
	pos4 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_summoned_stance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_summoned_stance, "configList", _configList)
	rawset(lua_fight_summoned_stance, "configDict", _configDict)
end

setmetatable(lua_fight_summoned_stance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_summoned_stance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_summoned_stance, "configList", nil)
	rawset(lua_fight_summoned_stance, "configDict", nil)
end

return lua_fight_summoned_stance
