-- chunkname: @modules/configs/excel2json/lua_rouge2_short_voice_group.lua

module("modules.configs.excel2json.lua_rouge2_short_voice_group", package.seeall)

local lua_rouge2_short_voice_group = {}
local fields = {
	id = 1,
	rate = 3,
	trigger = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_short_voice_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_short_voice_group, "configList", _configList)
	rawset(lua_rouge2_short_voice_group, "configDict", _configDict)
end

setmetatable(lua_rouge2_short_voice_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_short_voice_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_short_voice_group, "configList", nil)
	rawset(lua_rouge2_short_voice_group, "configDict", nil)
end

return lua_rouge2_short_voice_group
