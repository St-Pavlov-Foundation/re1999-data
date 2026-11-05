-- chunkname: @modules/configs/excel2json/lua_fight_upgrade_show_skillid.lua

module("modules.configs.excel2json.lua_fight_upgrade_show_skillid", package.seeall)

local lua_fight_upgrade_show_skillid = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_upgrade_show_skillid_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_upgrade_show_skillid, "configList", _configList)
	rawset(lua_fight_upgrade_show_skillid, "configDict", _configDict)
end

setmetatable(lua_fight_upgrade_show_skillid, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_upgrade_show_skillid.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_upgrade_show_skillid, "configList", nil)
	rawset(lua_fight_upgrade_show_skillid, "configDict", nil)
end

return lua_fight_upgrade_show_skillid
