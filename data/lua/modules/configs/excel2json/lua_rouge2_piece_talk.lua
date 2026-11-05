-- chunkname: @modules/configs/excel2json/lua_rouge2_piece_talk.lua

module("modules.configs.excel2json.lua_rouge2_piece_talk", package.seeall)

local lua_rouge2_piece_talk = {}
local fields = {
	title = 2,
	picture = 5,
	exitDesc = 6,
	id = 1,
	selectIds = 4,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	exitDesc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_piece_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_piece_talk, "configList", _configList)
	rawset(lua_rouge2_piece_talk, "configDict", _configDict)
end

setmetatable(lua_rouge2_piece_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_piece_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_piece_talk, "configList", nil)
	rawset(lua_rouge2_piece_talk, "configDict", nil)
end

return lua_rouge2_piece_talk
