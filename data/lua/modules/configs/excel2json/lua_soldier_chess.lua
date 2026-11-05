-- chunkname: @modules/configs/excel2json/lua_soldier_chess.lua

module("modules.configs.excel2json.lua_soldier_chess", package.seeall)

local lua_soldier_chess = {}
local fields = {
	cost = 8,
	name = 2,
	defaultPower = 6,
	type = 4,
	sell = 7,
	skillId = 12,
	resZoom = 11,
	formationDisplays = 3,
	resPic = 9,
	id = 1,
	resModel = 10,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.soldier_chess_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_soldier_chess, "configList", _configList)
	rawset(lua_soldier_chess, "configDict", _configDict)
end

setmetatable(lua_soldier_chess, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_soldier_chess.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_soldier_chess, "configList", nil)
	rawset(lua_soldier_chess, "configDict", nil)
end

return lua_soldier_chess
