-- chunkname: @modules/configs/excel2json/lua_critter_tag_effect.lua

module("modules.configs.excel2json.lua_critter_tag_effect", package.seeall)

local lua_critter_tag_effect = {}
local fields = {
	catalogue = 3,
	target = 2,
	previewCondition = 5,
	type = 6,
	id = 1,
	parameter = 7,
	condition = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_tag_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_tag_effect, "configList", _configList)
	rawset(lua_critter_tag_effect, "configDict", _configDict)
end

setmetatable(lua_critter_tag_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_tag_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_tag_effect, "configList", nil)
	rawset(lua_critter_tag_effect, "configDict", nil)
end

return lua_critter_tag_effect
