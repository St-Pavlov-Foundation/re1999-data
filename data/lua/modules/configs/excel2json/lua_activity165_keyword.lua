-- chunkname: @modules/configs/excel2json/lua_activity165_keyword.lua

module("modules.configs.excel2json.lua_activity165_keyword", package.seeall)

local lua_activity165_keyword = {}
local fields = {
	keywordId = 1,
	text = 3,
	pic = 4,
	belongStoryId = 2
}
local primaryKey = {
	"keywordId"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.activity165_keyword_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity165_keyword, "configList", _configList)
	rawset(lua_activity165_keyword, "configDict", _configDict)
end

setmetatable(lua_activity165_keyword, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity165_keyword.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity165_keyword, "configList", nil)
	rawset(lua_activity165_keyword, "configDict", nil)
end

return lua_activity165_keyword
