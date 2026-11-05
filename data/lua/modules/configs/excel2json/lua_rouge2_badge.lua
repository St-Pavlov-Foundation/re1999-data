-- chunkname: @modules/configs/excel2json/lua_rouge2_badge.lua

module("modules.configs.excel2json.lua_rouge2_badge", package.seeall)

local lua_rouge2_badge = {}
local fields = {
	score = 6,
	name = 2,
	id = 1,
	icon = 4,
	trigger = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_badge_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_badge, "configList", _configList)
	rawset(lua_rouge2_badge, "configDict", _configDict)
end

setmetatable(lua_rouge2_badge, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_badge.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_badge, "configList", nil)
	rawset(lua_rouge2_badge, "configDict", nil)
end

return lua_rouge2_badge
