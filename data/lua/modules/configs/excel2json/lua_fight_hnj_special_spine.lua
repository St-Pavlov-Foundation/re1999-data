-- chunkname: @modules/configs/excel2json/lua_fight_hnj_special_spine.lua

module("modules.configs.excel2json.lua_fight_hnj_special_spine", package.seeall)

local lua_fight_hnj_special_spine = {}
local fields = {
	dieAudio = 16,
	dieAnimDuration = 13,
	skinId = 1,
	dieAnim = 12,
	bornAudio = 8,
	pos = 3,
	bornPoint = 7,
	bornEffect = 6,
	resPath = 2,
	effect = 10,
	dieDuration = 17,
	dieEffect = 14,
	bornDuration = 9,
	bornAnim = 4,
	hangPoint = 11,
	bornAnimDuration = 5,
	diePoint = 15
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_hnj_special_spine_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_hnj_special_spine, "configList", _configList)
	rawset(lua_fight_hnj_special_spine, "configDict", _configDict)
end

setmetatable(lua_fight_hnj_special_spine, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_hnj_special_spine.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_hnj_special_spine, "configList", nil)
	rawset(lua_fight_hnj_special_spine, "configDict", nil)
end

return lua_fight_hnj_special_spine
