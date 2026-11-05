-- chunkname: @modules/configs/excel2json/lua_fight_eziozhuangbei_icon.lua

module("modules.configs.excel2json.lua_fight_eziozhuangbei_icon", package.seeall)

local lua_fight_eziozhuangbei_icon = {}
local fields = {
	weaponId = 1,
	name = 5,
	firsticon = 3,
	type = 2,
	secondicon = 4
}
local primaryKey = {
	"weaponId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.fight_eziozhuangbei_icon_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_eziozhuangbei_icon, "configList", _configList)
	rawset(lua_fight_eziozhuangbei_icon, "configDict", _configDict)
end

setmetatable(lua_fight_eziozhuangbei_icon, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_eziozhuangbei_icon.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_eziozhuangbei_icon, "configList", nil)
	rawset(lua_fight_eziozhuangbei_icon, "configDict", nil)
end

return lua_fight_eziozhuangbei_icon
