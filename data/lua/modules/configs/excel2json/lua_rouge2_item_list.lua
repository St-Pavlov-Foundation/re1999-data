-- chunkname: @modules/configs/excel2json/lua_rouge2_item_list.lua

module("modules.configs.excel2json.lua_rouge2_item_list", package.seeall)

local lua_rouge2_item_list = {}
local fields = {
	itemId = 2,
	unlockType = 4,
	conditionParam = 5,
	type = 3,
	id = 1,
	isHide = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_item_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_item_list, "configList", _configList)
	rawset(lua_rouge2_item_list, "configDict", _configDict)
end

setmetatable(lua_rouge2_item_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_item_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_item_list, "configList", nil)
	rawset(lua_rouge2_item_list, "configDict", nil)
end

return lua_rouge2_item_list
