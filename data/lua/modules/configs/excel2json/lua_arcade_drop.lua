-- chunkname: @modules/configs/excel2json/lua_arcade_drop.lua

module("modules.configs.excel2json.lua_arcade_drop", package.seeall)

local lua_arcade_drop = {}
local fields = {
	id = 1,
	characterunlock = 4,
	resourcedrop = 2,
	collectiondrop = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_drop, "configList", _configList)
	rawset(lua_arcade_drop, "configDict", _configDict)
end

setmetatable(lua_arcade_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_drop, "configList", nil)
	rawset(lua_arcade_drop, "configDict", nil)
end

return lua_arcade_drop
