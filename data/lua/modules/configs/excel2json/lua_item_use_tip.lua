-- chunkname: @modules/configs/excel2json/lua_item_use_tip.lua

module("modules.configs.excel2json.lua_item_use_tip", package.seeall)

local lua_item_use_tip = {}
local fields = {
	jumpId = 4,
	priority = 2,
	checkParam = 7,
	type = 3,
	id = 1,
	descParam = 6,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.item_use_tip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_item_use_tip, "configList", _configList)
	rawset(lua_item_use_tip, "configDict", _configDict)
end

setmetatable(lua_item_use_tip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_item_use_tip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_item_use_tip, "configList", nil)
	rawset(lua_item_use_tip, "configDict", nil)
end

return lua_item_use_tip
