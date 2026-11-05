-- chunkname: @modules/configs/excel2json/lua_rogue_event_tips.lua

module("modules.configs.excel2json.lua_rogue_event_tips", package.seeall)

local lua_rogue_event_tips = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rogue_event_tips_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_tips, "configList", _configList)
	rawset(lua_rogue_event_tips, "configDict", _configDict)
end

setmetatable(lua_rogue_event_tips, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_tips.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_tips, "configList", nil)
	rawset(lua_rogue_event_tips, "configDict", nil)
end

return lua_rogue_event_tips
