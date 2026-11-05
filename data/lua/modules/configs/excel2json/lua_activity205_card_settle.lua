-- chunkname: @modules/configs/excel2json/lua_activity205_card_settle.lua

module("modules.configs.excel2json.lua_activity205_card_settle", package.seeall)

local lua_activity205_card_settle = {}
local fields = {
	desc = 3,
	point = 1,
	rewardId = 2
}
local primaryKey = {
	"point"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity205_card_settle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity205_card_settle, "configList", _configList)
	rawset(lua_activity205_card_settle, "configDict", _configDict)
end

setmetatable(lua_activity205_card_settle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity205_card_settle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity205_card_settle, "configList", nil)
	rawset(lua_activity205_card_settle, "configDict", nil)
end

return lua_activity205_card_settle
