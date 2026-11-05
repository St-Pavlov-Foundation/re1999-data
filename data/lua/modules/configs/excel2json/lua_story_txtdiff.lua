-- chunkname: @modules/configs/excel2json/lua_story_txtdiff.lua

module("modules.configs.excel2json.lua_story_txtdiff", package.seeall)

local lua_story_txtdiff = {}
local fields = {
	kr = 6,
	de = 8,
	cn = 3,
	tw = 4,
	thai = 10,
	fr = 9,
	en = 5,
	jp = 7,
	id = 1,
	lanType = 2
}
local primaryKey = {
	"id",
	"lanType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_txtdiff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_txtdiff, "configList", _configList)
	rawset(lua_story_txtdiff, "configDict", _configDict)
end

setmetatable(lua_story_txtdiff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_txtdiff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_txtdiff, "configList", nil)
	rawset(lua_story_txtdiff, "configDict", nil)
end

return lua_story_txtdiff
