-- chunkname: @modules/configs/excel2json/lua_fight_skin_replace_magic_effect.lua

module("modules.configs.excel2json.lua_fight_skin_replace_magic_effect", package.seeall)

local lua_fight_skin_replace_magic_effect = {}
local fields = {
	closeEffect = 7,
	enterTime = 4,
	skinId = 2,
	closeTime = 8,
	enterEffect = 3,
	enterAudio = 5,
	posArr = 11,
	loopEffect = 6,
	id = 1,
	closeAudio = 10,
	closeAniName = 9
}
local primaryKey = {
	"id",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skin_replace_magic_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skin_replace_magic_effect, "configList", _configList)
	rawset(lua_fight_skin_replace_magic_effect, "configDict", _configDict)
end

setmetatable(lua_fight_skin_replace_magic_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skin_replace_magic_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skin_replace_magic_effect, "configList", nil)
	rawset(lua_fight_skin_replace_magic_effect, "configDict", nil)
end

return lua_fight_skin_replace_magic_effect
