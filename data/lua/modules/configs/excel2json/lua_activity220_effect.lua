-- chunkname: @modules/configs/excel2json/lua_activity220_effect.lua

module("modules.configs.excel2json.lua_activity220_effect", package.seeall)

local lua_activity220_effect = {}
local fields = {
	audio = 7,
	effect = 4,
	damage = 9,
	effectId = 1,
	effectSpeed = 5,
	effectTime = 6,
	keyTime = 8,
	percent = 10,
	isHurt = 3,
	isShow = 2
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_effect, "configList", _configList)
	rawset(lua_activity220_effect, "configDict", _configDict)
end

setmetatable(lua_activity220_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_effect, "configList", nil)
	rawset(lua_activity220_effect, "configDict", nil)
end

return lua_activity220_effect
