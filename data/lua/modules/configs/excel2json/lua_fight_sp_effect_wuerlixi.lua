-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi", package.seeall)

local lua_fight_sp_effect_wuerlixi = {}
local fields = {
	hangPoint = 4,
	effect = 3,
	channelHangPoint = 5,
	skinId = 2,
	buffTypeId = 1
}
local primaryKey = {
	"buffTypeId",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_wuerlixi_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_wuerlixi, "configList", _configList)
	rawset(lua_fight_sp_effect_wuerlixi, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_wuerlixi, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_wuerlixi.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_wuerlixi, "configList", nil)
	rawset(lua_fight_sp_effect_wuerlixi, "configDict", nil)
end

return lua_fight_sp_effect_wuerlixi
