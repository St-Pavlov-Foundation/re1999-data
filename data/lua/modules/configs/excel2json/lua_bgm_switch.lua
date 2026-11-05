-- chunkname: @modules/configs/excel2json/lua_bgm_switch.lua

module("modules.configs.excel2json.lua_bgm_switch", package.seeall)

local lua_bgm_switch = {}
local fields = {
	itemId = 5,
	audioIntroduce = 9,
	audioNameEn = 8,
	audio = 2,
	audioName = 7,
	unlockCondition = 4,
	audioicon = 11,
	sort = 12,
	audioType = 13,
	isNonLoop = 16,
	isReport = 3,
	audioBg = 10,
	id = 1,
	audioEvaluates = 15,
	audioLength = 14,
	defaultUnlock = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	audioIntroduce = 2,
	audioEvaluates = 3,
	audioName = 1
}
local _configList, _configDict
local configPath = "configs.bgm_switch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bgm_switch, "configList", _configList)
	rawset(lua_bgm_switch, "configDict", _configDict)
end

setmetatable(lua_bgm_switch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bgm_switch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bgm_switch, "configList", nil)
	rawset(lua_bgm_switch, "configDict", nil)
end

return lua_bgm_switch
