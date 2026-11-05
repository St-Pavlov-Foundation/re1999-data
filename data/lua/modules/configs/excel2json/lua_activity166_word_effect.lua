-- chunkname: @modules/configs/excel2json/lua_activity166_word_effect.lua

module("modules.configs.excel2json.lua_activity166_word_effect", package.seeall)

local lua_activity166_word_effect = {}
local fields = {
	id = 2,
	type = 4,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity166_word_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_word_effect, "configList", _configList)
	rawset(lua_activity166_word_effect, "configDict", _configDict)
end

setmetatable(lua_activity166_word_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_word_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_word_effect, "configList", nil)
	rawset(lua_activity166_word_effect, "configDict", nil)
end

return lua_activity166_word_effect
