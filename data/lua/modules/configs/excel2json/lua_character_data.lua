-- chunkname: @modules/configs/excel2json/lua_character_data.lua

module("modules.configs.excel2json.lua_character_data", package.seeall)

local lua_character_data = {}
local fields = {
	skinId = 3,
	lockText = 11,
	unlockConditine = 12,
	type = 4,
	isCustom = 14,
	title = 6,
	unlockRewards = 13,
	number = 5,
	text = 8,
	heroId = 1,
	titleEn = 7,
	id = 2,
	icon = 9,
	estimate = 10
}
local primaryKey = {
	"heroId",
	"id"
}
local mlStringKey = {
	text = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.character_data_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_data, "configList", _configList)
	rawset(lua_character_data, "configDict", _configDict)
end

setmetatable(lua_character_data, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_data.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_data, "configList", nil)
	rawset(lua_character_data, "configDict", nil)
end

return lua_character_data
