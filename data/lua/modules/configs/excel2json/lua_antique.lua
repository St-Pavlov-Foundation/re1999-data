-- chunkname: @modules/configs/excel2json/lua_antique.lua

module("modules.configs.excel2json.lua_antique", package.seeall)

local lua_antique = {}
local fields = {
	sources = 10,
	name = 2,
	storyId = 11,
	nameen = 3,
	effect = 13,
	title = 7,
	desc = 9,
	titleen = 8,
	gifticon = 5,
	sign = 6,
	id = 1,
	icon = 4,
	iconArea = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 2,
	name = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.antique_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_antique, "configList", _configList)
	rawset(lua_antique, "configDict", _configDict)
end

setmetatable(lua_antique, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_antique.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_antique, "configList", nil)
	rawset(lua_antique, "configDict", nil)
end

return lua_antique
