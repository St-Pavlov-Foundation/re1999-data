-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map_piece.lua

module("modules.configs.excel2json.lua_activity220_wmz_map_piece", package.seeall)

local lua_activity220_wmz_map_piece = {}
local fields = {
	id = 1,
	mapId = 2,
	pieceMinY = 5,
	pieceMaxX = 6,
	pieceMinX = 4,
	pieceMaxY = 7,
	pieceResNamePrefix = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_wmz_map_piece_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_wmz_map_piece, "configList", _configList)
	rawset(lua_activity220_wmz_map_piece, "configDict", _configDict)
end

setmetatable(lua_activity220_wmz_map_piece, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_wmz_map_piece.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_wmz_map_piece, "configList", nil)
	rawset(lua_activity220_wmz_map_piece, "configDict", nil)
end

return lua_activity220_wmz_map_piece
