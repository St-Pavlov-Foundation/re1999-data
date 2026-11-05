-- chunkname: @modules/configs/excel2json/lua_v3a6_warmup_story.lua

module("modules.configs.excel2json.lua_v3a6_warmup_story", package.seeall)

local lua_v3a6_warmup_story = {}
local fields = {
	group = 2,
	cutscene = 4,
	id = 1,
	bg = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.v3a6_warmup_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a6_warmup_story, "configList", _configList)
	rawset(lua_v3a6_warmup_story, "configDict", _configDict)
end

setmetatable(lua_v3a6_warmup_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a6_warmup_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a6_warmup_story, "configList", nil)
	rawset(lua_v3a6_warmup_story, "configDict", nil)
end

return lua_v3a6_warmup_story
