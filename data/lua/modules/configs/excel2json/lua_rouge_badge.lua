-- chunkname: @modules/configs/excel2json/lua_rouge_badge.lua

module("modules.configs.excel2json.lua_rouge_badge", package.seeall)

local lua_rouge_badge = {}
local fields = {
	score = 8,
	name = 3,
	triggerParam = 7,
	id = 2,
	season = 1,
	icon = 5,
	trigger = 6,
	desc = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_badge, "configList", _configList)
	rawset(lua_rouge_badge, "configDict", _configDict)
end

setmetatable(lua_rouge_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_badge, "configList", nil)
	rawset(lua_rouge_badge, "configDict", nil)
end

return lua_rouge_badge
