-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_effect.lua

module("modules.configs.excel2json.lua_activity220_hedone_effect", package.seeall)

local lua_activity220_hedone_effect = {}
local fields = {
	hitAudio = 16,
	lifeRule = 8,
	lifeParam = 9,
	effectId = 1,
	entityRes = 5,
	triggerInterval = 10,
	range = 11,
	effectGroup = 2,
	valueMul = 12,
	effectType = 3,
	triggerEffect = 13,
	triggerEffectDuration = 14,
	isDetachedEff = 6,
	hitEffect = 15,
	effectParam = 4,
	ignoreSelf = 7
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_hedone_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hedone_effect, "configList", _configList)
	rawset(lua_activity220_hedone_effect, "configDict", _configDict)
end

setmetatable(lua_activity220_hedone_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hedone_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hedone_effect, "configList", nil)
	rawset(lua_activity220_hedone_effect, "configDict", nil)
end

return lua_activity220_hedone_effect
