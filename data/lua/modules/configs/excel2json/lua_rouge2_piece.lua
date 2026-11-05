-- chunkname: @modules/configs/excel2json/lua_rouge2_piece.lua

module("modules.configs.excel2json.lua_rouge2_piece", package.seeall)

local lua_rouge2_piece = {}
local fields = {
	entrustType = 2,
	talkId = 6,
	pieceRes = 3,
	id = 1,
	title = 4,
	bossEffect = 7,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_piece_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_piece, "configList", _configList)
	rawset(lua_rouge2_piece, "configDict", _configDict)
end

setmetatable(lua_rouge2_piece, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_piece.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_piece, "configList", nil)
	rawset(lua_rouge2_piece, "configDict", nil)
end

return lua_rouge2_piece
