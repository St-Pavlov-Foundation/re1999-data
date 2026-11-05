-- chunkname: @modules/configs/excel2json/lua_arcade_talent.lua

module("modules.configs.excel2json.lua_arcade_talent", package.seeall)

local lua_arcade_talent = {}
local fields = {
	cost = 3,
	name = 4,
	skill = 6,
	displayType = 5,
	id = 1,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_talent, "configList", _configList)
	rawset(lua_arcade_talent, "configDict", _configDict)
end

setmetatable(lua_arcade_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_talent, "configList", nil)
	rawset(lua_arcade_talent, "configDict", nil)
end

return lua_arcade_talent
