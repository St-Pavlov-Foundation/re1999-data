-- chunkname: @modules/configs/excel2json/lua_storyskip.lua

module("modules.configs.excel2json.lua_storyskip", package.seeall)

local lua_storyskip = {}
local fields = {
	id = 1,
	skipDetail = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.storyskip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_storyskip, "configList", _configList)
	rawset(lua_storyskip, "configDict", _configDict)
end

setmetatable(lua_storyskip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_storyskip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_storyskip, "configList", nil)
	rawset(lua_storyskip, "configDict", nil)
end

return lua_storyskip
