-- chunkname: @modules/configs/excel2json/lua_battle_selection.lua

module("modules.configs.excel2json.lua_battle_selection", package.seeall)

local lua_battle_selection = {}
local fields = {
	title = 2,
	autoUse2 = 8,
	confirm = 5,
	autoUse1 = 7,
	id = 1,
	icon = 4,
	nextSelect = 6,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	confirm = 3,
	title = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.battle_selection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_battle_selection, "configList", _configList)
	rawset(lua_battle_selection, "configDict", _configDict)
end

setmetatable(lua_battle_selection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_battle_selection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_battle_selection, "configList", nil)
	rawset(lua_battle_selection, "configDict", nil)
end

return lua_battle_selection
