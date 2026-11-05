-- chunkname: @modules/configs/excel2json/lua_rouge_piece.lua

module("modules.configs.excel2json.lua_rouge_piece", package.seeall)

local lua_rouge_piece = {}
local fields = {
	version = 2,
	title = 5,
	talkId = 7,
	pieceRes = 4,
	id = 1,
	entrustType = 3,
	bossEffect = 8,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_piece_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_piece, "configList", _configList)
	rawset(lua_rouge_piece, "configDict", _configDict)
end

setmetatable(lua_rouge_piece, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_piece.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_piece, "configList", nil)
	rawset(lua_rouge_piece, "configDict", nil)
end

return lua_rouge_piece
