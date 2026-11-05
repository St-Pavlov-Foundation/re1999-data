-- chunkname: @modules/configs/excel2json/lua_dialogue_chess_info.lua

module("modules.configs.excel2json.lua_dialogue_chess_info", package.seeall)

local lua_dialogue_chess_info = {}
local fields = {
	id = 2,
	res = 3,
	dialogueId = 1,
	pos = 4
}
local primaryKey = {
	"dialogueId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dialogue_chess_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dialogue_chess_info, "configList", _configList)
	rawset(lua_dialogue_chess_info, "configDict", _configDict)
end

setmetatable(lua_dialogue_chess_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dialogue_chess_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dialogue_chess_info, "configList", nil)
	rawset(lua_dialogue_chess_info, "configDict", nil)
end

return lua_dialogue_chess_info
