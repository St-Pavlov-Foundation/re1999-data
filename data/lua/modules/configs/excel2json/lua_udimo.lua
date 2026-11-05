-- chunkname: @modules/configs/excel2json/lua_udimo.lua

module("modules.configs.excel2json.lua_udimo", package.seeall)

local lua_udimo = {}
local fields = {
	id = 1,
	name = 2,
	defaultUse = 6,
	colliderOffset = 9,
	groupId = 3,
	imgParam = 11,
	spineParam = 12,
	resource = 7,
	colliderSize = 8,
	heroId = 4,
	outlineRes = 14,
	orderLayer = 15,
	isDefault = 5,
	resourceParam = 13,
	emojiPos = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.udimo_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo, "configList", _configList)
	rawset(lua_udimo, "configDict", _configDict)
end

setmetatable(lua_udimo, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo, "configList", nil)
	rawset(lua_udimo, "configDict", nil)
end

return lua_udimo
