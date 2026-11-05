-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_chess.lua

module("modules.configs.excel2json.lua_tower_v3a7_chess", package.seeall)

local lua_tower_v3a7_chess = {}
local fields = {
	map = 15,
	name = 2,
	location = 10,
	desc1 = 3,
	appear = 9,
	belong = 5,
	dialogue2 = 12,
	move = 8,
	head = 13,
	skill2 = 14,
	skill1 = 4,
	health = 7,
	id = 1,
	defaultHealth = 6,
	dialogue1 = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	dialogue1 = 3,
	name = 1,
	dialogue2 = 4,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.tower_v3a7_chess_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_v3a7_chess, "configList", _configList)
	rawset(lua_tower_v3a7_chess, "configDict", _configDict)
end

setmetatable(lua_tower_v3a7_chess, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_v3a7_chess.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_v3a7_chess, "configList", nil)
	rawset(lua_tower_v3a7_chess, "configDict", nil)
end

return lua_tower_v3a7_chess
