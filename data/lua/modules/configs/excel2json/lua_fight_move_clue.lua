-- chunkname: @modules/configs/excel2json/lua_fight_move_clue.lua

module("modules.configs.excel2json.lua_fight_move_clue", package.seeall)

local lua_fight_move_clue = {}
local fields = {
	facetsId = 3,
	heroId = 2,
	effect = 5,
	clueId = 1,
	icon = 4
}
local primaryKey = {
	"clueId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_move_clue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_move_clue, "configList", _configList)
	rawset(lua_fight_move_clue, "configDict", _configDict)
end

setmetatable(lua_fight_move_clue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_move_clue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_move_clue, "configList", nil)
	rawset(lua_fight_move_clue, "configDict", nil)
end

return lua_fight_move_clue
