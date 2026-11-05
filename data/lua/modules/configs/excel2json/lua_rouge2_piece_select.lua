-- chunkname: @modules/configs/excel2json/lua_rouge2_piece_select.lua

module("modules.configs.excel2json.lua_rouge2_piece_select", package.seeall)

local lua_rouge2_piece_select = {}
local fields = {
	check = 4,
	descBigSuccess = 11,
	afterSelect = 5,
	descSuccess = 9,
	checkId = 6,
	title = 7,
	content = 8,
	unlock = 2,
	descLose = 10,
	triggerType = 12,
	triggerParam = 13,
	display = 14,
	id = 1,
	active = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_piece_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_piece_select, "configList", _configList)
	rawset(lua_rouge2_piece_select, "configDict", _configDict)
end

setmetatable(lua_rouge2_piece_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_piece_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_piece_select, "configList", nil)
	rawset(lua_rouge2_piece_select, "configDict", nil)
end

return lua_rouge2_piece_select
