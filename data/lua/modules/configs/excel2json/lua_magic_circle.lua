-- chunkname: @modules/configs/excel2json/lua_magic_circle.lua

module("modules.configs.excel2json.lua_magic_circle", package.seeall)

local lua_magic_circle = {}
local fields = {
	consumeNum = 7,
	enemySkills = 13,
	selfSkills = 12,
	closeTime = 22,
	selfAttrs = 10,
	enterAudio = 19,
	endSkills = 16,
	desc = 3,
	circleType = 8,
	enterTime = 18,
	consumeType = 6,
	name = 2,
	complexEffect = 9,
	closeAudio = 24,
	enemyBuff = 15,
	enemyAttrs = 11,
	selfBuff = 14,
	closeEffect = 21,
	enterEffect = 17,
	posArr = 25,
	round = 5,
	loopEffect = 20,
	id = 1,
	uiType = 4,
	closeAniName = 23
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.magic_circle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_magic_circle, "configList", _configList)
	rawset(lua_magic_circle, "configDict", _configDict)
end

setmetatable(lua_magic_circle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_magic_circle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_magic_circle, "configList", nil)
	rawset(lua_magic_circle, "configDict", nil)
end

return lua_magic_circle
