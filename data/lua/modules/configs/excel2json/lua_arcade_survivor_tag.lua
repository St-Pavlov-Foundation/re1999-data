-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_tag.lua

module("modules.configs.excel2json.lua_arcade_survivor_tag", package.seeall)

local lua_arcade_survivor_tag = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_tag, "configList", _configList)
	rawset(lua_arcade_survivor_tag, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_tag, "configList", nil)
	rawset(lua_arcade_survivor_tag, "configDict", nil)
end

return lua_arcade_survivor_tag
