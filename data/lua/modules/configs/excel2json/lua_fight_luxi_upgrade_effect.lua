-- chunkname: @modules/configs/excel2json/lua_fight_luxi_upgrade_effect.lua

module("modules.configs.excel2json.lua_fight_luxi_upgrade_effect", package.seeall)

local lua_fight_luxi_upgrade_effect = {}
local fields = {
	effect = 5,
	effectType = 3,
	buffId = 2,
	countOffset = 4,
	id = 1,
	effectHangPoint = 6,
	audio = 7
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_luxi_upgrade_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_luxi_upgrade_effect, "configList", _configList)
	rawset(lua_fight_luxi_upgrade_effect, "configDict", _configDict)
end

setmetatable(lua_fight_luxi_upgrade_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_luxi_upgrade_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_luxi_upgrade_effect, "configList", nil)
	rawset(lua_fight_luxi_upgrade_effect, "configDict", nil)
end

return lua_fight_luxi_upgrade_effect
