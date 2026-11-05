-- chunkname: @modules/configs/excel2json/lua_partygame_param.lua

module("modules.configs.excel2json.lua_partygame_param", package.seeall)

local lua_partygame_param = {}
local fields = {
	focus = 10,
	name = 3,
	camera = 9,
	moveSpeed = 8,
	online = 2,
	envMusic = 17,
	limitTime = 20,
	desc = 4,
	envMusicStop = 18,
	helpId = 19,
	sceneAssetId = 5,
	playerPos = 15,
	isFocusPlayer = 11,
	posIndexLock = 13,
	roleCol = 21,
	openLog = 22,
	bgmId = 16,
	canTeam = 6,
	focusLimit = 12,
	id = 1,
	gameTime = 14,
	weight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.partygame_param_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_param, "configList", _configList)
	rawset(lua_partygame_param, "configDict", _configDict)
end

setmetatable(lua_partygame_param, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_param.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_param, "configList", nil)
	rawset(lua_partygame_param, "configDict", nil)
end

return lua_partygame_param
