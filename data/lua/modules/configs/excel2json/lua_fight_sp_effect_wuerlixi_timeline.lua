-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi_timeline.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi_timeline", package.seeall)

local lua_fight_sp_effect_wuerlixi_timeline = {}
local fields = {
	mySideTimeline = 2,
	enemySideTimeline = 3,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_wuerlixi_timeline_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_wuerlixi_timeline, "configList", _configList)
	rawset(lua_fight_sp_effect_wuerlixi_timeline, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_wuerlixi_timeline, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_wuerlixi_timeline.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_wuerlixi_timeline, "configList", nil)
	rawset(lua_fight_sp_effect_wuerlixi_timeline, "configDict", nil)
end

return lua_fight_sp_effect_wuerlixi_timeline
