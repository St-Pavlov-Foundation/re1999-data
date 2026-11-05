-- chunkname: @modules/configs/excel2json/lua_rouge_piece_select.lua

module("modules.configs.excel2json.lua_rouge_piece_select", package.seeall)

local lua_rouge_piece_select = {}
local fields = {
	activeParam = 5,
	display = 11,
	triggerParam = 10,
	unlockParam = 3,
	id = 1,
	title = 6,
	content = 7,
	triggerType = 9,
	unlockType = 2,
	activeType = 4,
	talkDesc = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	talkDesc = 3,
	title = 1,
	content = 2
}
local _configList, _configDict
local configPath = "configs.rouge_piece_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_piece_select, "configList", _configList)
	rawset(lua_rouge_piece_select, "configDict", _configDict)
end

setmetatable(lua_rouge_piece_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_piece_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_piece_select, "configList", nil)
	rawset(lua_rouge_piece_select, "configDict", nil)
end

return lua_rouge_piece_select
