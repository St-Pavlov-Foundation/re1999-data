-- chunkname: @modules/configs/excel2json/lua_skill_buff.lua

module("modules.configs.excel2json.lua_skill_buff", package.seeall)

local lua_skill_buff = {}
local fields = {
	triggerAudio = 20,
	name = 2,
	desc = 3,
	duringTime = 6,
	effectCount = 7,
	isNoShow = 4,
	animationName = 14,
	mat = 15,
	bloommat = 16,
	delEffect = 22,
	triggerEffect = 18,
	delEffectHangPoint = 23,
	effectHangPoint = 13,
	features = 8,
	triggerAnimationName = 21,
	delAudio = 24,
	delAnimator = 25,
	effect = 11,
	audio = 17,
	typeId = 9,
	effectloop = 12,
	iconId = 10,
	triggerEffectHangPoint = 19,
	isGoodBuff = 5,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.skill_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_buff, "configList", _configList)
	rawset(lua_skill_buff, "configDict", _configDict)
end

setmetatable(lua_skill_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_buff, "configList", nil)
	rawset(lua_skill_buff, "configDict", nil)
end

return lua_skill_buff
