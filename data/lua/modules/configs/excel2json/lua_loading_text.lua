-- chunkname: @modules/configs/excel2json/lua_loading_text.lua

module("modules.configs.excel2json.lua_loading_text", package.seeall)

local lua_loading_text = {}
local fields = {
	unlocklevel = 2,
	isOnline = 8,
	content = 6,
	titleen = 5,
	id = 1,
	title = 4,
	weight = 3,
	scenes = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.loading_text_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_loading_text, "configList", _configList)
	rawset(lua_loading_text, "configDict", _configDict)
end

setmetatable(lua_loading_text, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_loading_text.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_loading_text, "configList", nil)
	rawset(lua_loading_text, "configDict", nil)
end

return lua_loading_text
