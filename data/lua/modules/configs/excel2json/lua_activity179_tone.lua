-- chunkname: @modules/configs/excel2json/lua_activity179_tone.lua

module("modules.configs.excel2json.lua_activity179_tone", package.seeall)

local lua_activity179_tone = {}
local fields = {
	id = 1,
	name = 3,
	instrument = 2,
	resource = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity179_tone_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_tone, "configList", _configList)
	rawset(lua_activity179_tone, "configDict", _configDict)
end

setmetatable(lua_activity179_tone, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_tone.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_tone, "configList", nil)
	rawset(lua_activity179_tone, "configDict", nil)
end

return lua_activity179_tone
