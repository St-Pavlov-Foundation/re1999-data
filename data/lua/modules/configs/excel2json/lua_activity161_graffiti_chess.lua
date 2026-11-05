-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_chess.lua

module("modules.configs.excel2json.lua_activity161_graffiti_chess", package.seeall)

local lua_activity161_graffiti_chess = {}
local fields = {
	chessId = 1,
	pos = 3,
	resource = 2
}
local primaryKey = {
	"chessId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity161_graffiti_chess_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity161_graffiti_chess, "configList", _configList)
	rawset(lua_activity161_graffiti_chess, "configDict", _configDict)
end

setmetatable(lua_activity161_graffiti_chess, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity161_graffiti_chess.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity161_graffiti_chess, "configList", nil)
	rawset(lua_activity161_graffiti_chess, "configDict", nil)
end

return lua_activity161_graffiti_chess
