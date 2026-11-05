-- chunkname: @modules/configs/excel2json/lua_fight_card_pre_delete.lua

module("modules.configs.excel2json.lua_fight_card_pre_delete", package.seeall)

local lua_fight_card_pre_delete = {}
local fields = {
	skillID = 1,
	left = 2,
	right = 3
}
local primaryKey = {
	"skillID"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_card_pre_delete_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_card_pre_delete, "configList", _configList)
	rawset(lua_fight_card_pre_delete, "configDict", _configDict)
end

setmetatable(lua_fight_card_pre_delete, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_card_pre_delete.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_card_pre_delete, "configList", nil)
	rawset(lua_fight_card_pre_delete, "configDict", nil)
end

return lua_fight_card_pre_delete
