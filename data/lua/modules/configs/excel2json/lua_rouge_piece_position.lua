-- chunkname: @modules/configs/excel2json/lua_rouge_piece_position.lua

module("modules.configs.excel2json.lua_rouge_piece_position", package.seeall)

local lua_rouge_piece_position = {}
local fields = {
	layerId = 3,
	unlockParam = 5,
	version = 2,
	pieceRes = 8,
	talkId = 11,
	entrustType = 7,
	title = 9,
	desc = 10,
	unlockType = 4,
	talkView = 12,
	id = 1,
	icon = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_piece_position_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_piece_position, "configList", _configList)
	rawset(lua_rouge_piece_position, "configDict", _configDict)
end

setmetatable(lua_rouge_piece_position, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_piece_position.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_piece_position, "configList", nil)
	rawset(lua_rouge_piece_position, "configDict", nil)
end

return lua_rouge_piece_position
