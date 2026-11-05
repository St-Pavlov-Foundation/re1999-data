-- chunkname: @modules/configs/excel2json/lua_story_pictxt.lua

module("modules.configs.excel2json.lua_story_pictxt", package.seeall)

local lua_story_pictxt = {}
local fields = {
	kr = 6,
	de = 8,
	zh = 3,
	tw = 4,
	fontType = 2,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	thai = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_pictxt_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_pictxt, "configList", _configList)
	rawset(lua_story_pictxt, "configDict", _configDict)
end

setmetatable(lua_story_pictxt, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_pictxt.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_pictxt, "configList", nil)
	rawset(lua_story_pictxt, "configDict", nil)
end

return lua_story_pictxt
