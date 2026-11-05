-- chunkname: @modules/configs/excel2json/lua_fight_move_cluepoint.lua

module("modules.configs.excel2json.lua_fight_move_cluepoint", package.seeall)

local lua_fight_move_cluepoint = {}
local fields = {
	heroId = 2,
	cluepoint = 1,
	facetsId = 3
}
local primaryKey = {
	"cluepoint"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_move_cluepoint_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_move_cluepoint, "configList", _configList)
	rawset(lua_fight_move_cluepoint, "configDict", _configDict)
end

setmetatable(lua_fight_move_cluepoint, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_move_cluepoint.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_move_cluepoint, "configList", nil)
	rawset(lua_fight_move_cluepoint, "configDict", nil)
end

return lua_fight_move_cluepoint
