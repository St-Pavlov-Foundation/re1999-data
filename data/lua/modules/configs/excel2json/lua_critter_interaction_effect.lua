-- chunkname: @modules/configs/excel2json/lua_critter_interaction_effect.lua

module("modules.configs.excel2json.lua_critter_interaction_effect", package.seeall)

local lua_critter_interaction_effect = {}
local fields = {
	animName = 5,
	effectKey = 6,
	point = 3,
	skinId = 1,
	id = 2,
	effectRes = 4
}
local primaryKey = {
	"skinId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_interaction_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_interaction_effect, "configList", _configList)
	rawset(lua_critter_interaction_effect, "configDict", _configDict)
end

setmetatable(lua_critter_interaction_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_interaction_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_interaction_effect, "configList", nil)
	rawset(lua_critter_interaction_effect, "configDict", nil)
end

return lua_critter_interaction_effect
