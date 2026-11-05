-- chunkname: @modules/configs/excel2json/lua_activity166_word_effect_pos.lua

module("modules.configs.excel2json.lua_activity166_word_effect_pos", package.seeall)

local lua_activity166_word_effect_pos = {}
local fields = {
	id = 2,
	pos = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity166_word_effect_pos_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_word_effect_pos, "configList", _configList)
	rawset(lua_activity166_word_effect_pos, "configDict", _configDict)
end

setmetatable(lua_activity166_word_effect_pos, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_word_effect_pos.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_word_effect_pos, "configList", nil)
	rawset(lua_activity166_word_effect_pos, "configDict", nil)
end

return lua_activity166_word_effect_pos
