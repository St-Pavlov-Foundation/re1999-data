-- chunkname: @modules/configs/excel2json/lua_party_cloth_suit.lua

module("modules.configs.excel2json.lua_party_cloth_suit", package.seeall)

local lua_party_cloth_suit = {}
local fields = {
	id = 1,
	name = 2,
	rare = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.party_cloth_suit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_cloth_suit, "configList", _configList)
	rawset(lua_party_cloth_suit, "configDict", _configDict)
end

setmetatable(lua_party_cloth_suit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_cloth_suit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_cloth_suit, "configList", nil)
	rawset(lua_party_cloth_suit, "configDict", nil)
end

return lua_party_cloth_suit
