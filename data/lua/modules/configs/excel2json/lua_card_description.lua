-- chunkname: @modules/configs/excel2json/lua_card_description.lua

module("modules.configs.excel2json.lua_card_description", package.seeall)

local lua_card_description = {}
local fields = {
	card2 = 4,
	card1 = 2,
	cardname_en = 5,
	cardname = 6,
	id = 1,
	carddescription2 = 8,
	carddescription1 = 7,
	attribute = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	carddescription1 = 2,
	carddescription2 = 3,
	cardname = 1
}
local _configList, _configDict
local configPath = "configs.card_description_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_card_description, "configList", _configList)
	rawset(lua_card_description, "configDict", _configDict)
end

setmetatable(lua_card_description, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_card_description.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_card_description, "configList", nil)
	rawset(lua_card_description, "configDict", nil)
end

return lua_card_description
