-- chunkname: @modules/configs/excel2json/lua_rouge2_effect.lua

module("modules.configs.excel2json.lua_rouge2_effect", package.seeall)

local lua_rouge2_effect = {}
local fields = {
	tips = 2,
	id = 1,
	typeParam = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_effect, "configList", _configList)
	rawset(lua_rouge2_effect, "configDict", _configDict)
end

setmetatable(lua_rouge2_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_effect, "configList", nil)
	rawset(lua_rouge2_effect, "configDict", nil)
end

return lua_rouge2_effect
