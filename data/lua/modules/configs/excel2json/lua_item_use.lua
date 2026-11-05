-- chunkname: @modules/configs/excel2json/lua_item_use.lua

module("modules.configs.excel2json.lua_item_use", package.seeall)

local lua_item_use = {}
local fields = {
	id = 1,
	name = 2,
	use_max = 4,
	useType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.item_use_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_item_use, "configList", _configList)
	rawset(lua_item_use, "configDict", _configDict)
end

setmetatable(lua_item_use, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_item_use.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_item_use, "configList", nil)
	rawset(lua_item_use, "configDict", nil)
end

return lua_item_use
