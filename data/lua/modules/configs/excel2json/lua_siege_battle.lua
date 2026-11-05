-- chunkname: @modules/configs/excel2json/lua_siege_battle.lua

module("modules.configs.excel2json.lua_siege_battle", package.seeall)

local lua_siege_battle = {}
local fields = {
	stage = 2,
	heroId = 5,
	instructionDesc = 6,
	episodeId = 7,
	id = 1,
	unlockCondition = 4,
	sort = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	instructionDesc = 1
}
local _configList, _configDict
local configPath = "configs.siege_battle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_siege_battle, "configList", _configList)
	rawset(lua_siege_battle, "configDict", _configDict)
end

setmetatable(lua_siege_battle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_siege_battle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_siege_battle, "configList", nil)
	rawset(lua_siege_battle, "configDict", nil)
end

return lua_siege_battle
