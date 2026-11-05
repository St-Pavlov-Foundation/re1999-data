-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_endless_mode.lua

module("modules.configs.excel2json.lua_eliminate_battle_endless_mode", package.seeall)

local lua_eliminate_battle_endless_mode = {}
local fields = {
	powerUp3 = 8,
	skill2 = 5,
	powerUp1 = 4,
	skill4 = 9,
	powerUp4 = 10,
	skill5 = 11,
	skill3 = 7,
	powerUp2 = 6,
	skill1 = 3,
	id = 1,
	powerUp5 = 12,
	hpUp = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_battle_endless_mode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_endless_mode, "configList", _configList)
	rawset(lua_eliminate_battle_endless_mode, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_endless_mode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_endless_mode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_endless_mode, "configList", nil)
	rawset(lua_eliminate_battle_endless_mode, "configDict", nil)
end

return lua_eliminate_battle_endless_mode
