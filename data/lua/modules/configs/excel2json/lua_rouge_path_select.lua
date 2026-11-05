-- chunkname: @modules/configs/excel2json/lua_rouge_path_select.lua

module("modules.configs.excel2json.lua_rouge_path_select", package.seeall)

local lua_rouge_path_select = {}
local fields = {
	startPos = 7,
	name = 3,
	focusMapPos = 5,
	endPos = 8,
	id = 1,
	version = 2,
	focusCameraSize = 6,
	mapRes = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_path_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_path_select, "configList", _configList)
	rawset(lua_rouge_path_select, "configDict", _configDict)
end

setmetatable(lua_rouge_path_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_path_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_path_select, "configList", nil)
	rawset(lua_rouge_path_select, "configDict", nil)
end

return lua_rouge_path_select
