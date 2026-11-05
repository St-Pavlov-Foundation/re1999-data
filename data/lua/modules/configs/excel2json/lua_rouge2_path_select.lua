-- chunkname: @modules/configs/excel2json/lua_rouge2_path_select.lua

module("modules.configs.excel2json.lua_rouge2_path_select", package.seeall)

local lua_rouge2_path_select = {}
local fields = {
	simageMapPos = 3,
	startPos = 4,
	confirmDesc = 6,
	id = 1,
	startDesc = 5,
	mapRes = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	startDesc = 1,
	confirmDesc = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_path_select_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_path_select, "configList", _configList)
	rawset(lua_rouge2_path_select, "configDict", _configDict)
end

setmetatable(lua_rouge2_path_select, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_path_select.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_path_select, "configList", nil)
	rawset(lua_rouge2_path_select, "configDict", nil)
end

return lua_rouge2_path_select
