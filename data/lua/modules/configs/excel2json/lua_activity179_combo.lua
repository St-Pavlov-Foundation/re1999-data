-- chunkname: @modules/configs/excel2json/lua_activity179_combo.lua

module("modules.configs.excel2json.lua_activity179_combo", package.seeall)

local lua_activity179_combo = {}
local fields = {
	score = 4,
	combo = 3,
	resource = 5,
	id = 1,
	episodeId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity179_combo_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_combo, "configList", _configList)
	rawset(lua_activity179_combo, "configDict", _configDict)
end

setmetatable(lua_activity179_combo, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_combo.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_combo, "configList", nil)
	rawset(lua_activity179_combo, "configDict", nil)
end

return lua_activity179_combo
