-- chunkname: @modules/configs/excel2json/lua_fight_luxi_skin_effect.lua

module("modules.configs.excel2json.lua_fight_luxi_skin_effect", package.seeall)

local lua_fight_luxi_skin_effect = {}
local fields = {
	effectDuration = 4,
	effect = 3,
	effectHangPoint = 5,
	audio = 6,
	id = 1,
	actionName = 2
}
local primaryKey = {
	"id",
	"actionName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_luxi_skin_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_luxi_skin_effect, "configList", _configList)
	rawset(lua_fight_luxi_skin_effect, "configDict", _configDict)
end

setmetatable(lua_fight_luxi_skin_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_luxi_skin_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_luxi_skin_effect, "configList", nil)
	rawset(lua_fight_luxi_skin_effect, "configDict", nil)
end

return lua_fight_luxi_skin_effect
