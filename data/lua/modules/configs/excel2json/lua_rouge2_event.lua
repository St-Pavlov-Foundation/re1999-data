-- chunkname: @modules/configs/excel2json/lua_rouge2_event.lua

module("modules.configs.excel2json.lua_rouge2_event", package.seeall)

local lua_rouge2_event = {}
local fields = {
	isHighQuality = 10,
	name = 4,
	type = 2,
	image = 3,
	desc = 6,
	advantageAttribute = 9,
	id = 1,
	mainDesc = 7,
	eventParam = 8,
	nameEn = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	nameEn = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_event, "configList", _configList)
	rawset(lua_rouge2_event, "configDict", _configDict)
end

setmetatable(lua_rouge2_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_event, "configList", nil)
	rawset(lua_rouge2_event, "configDict", nil)
end

return lua_rouge2_event
