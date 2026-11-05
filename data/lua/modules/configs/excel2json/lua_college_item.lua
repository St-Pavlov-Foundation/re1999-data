-- chunkname: @modules/configs/excel2json/lua_college_item.lua

module("modules.configs.excel2json.lua_college_item", package.seeall)

local lua_college_item = {}
local fields = {
	max = 5,
	name = 2,
	type = 6,
	id = 1,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_item_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_item, "configList", _configList)
	rawset(lua_college_item, "configDict", _configDict)
end

setmetatable(lua_college_item, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_item.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_item, "configList", nil)
	rawset(lua_college_item, "configDict", nil)
end

return lua_college_item
