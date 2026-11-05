-- chunkname: @modules/configs/excel2json/lua_weekwalk_element.lua

module("modules.configs.excel2json.lua_weekwalk_element", package.seeall)

local lua_weekwalk_element = {}
local fields = {
	isBoss = 7,
	smokeMaskOffset = 12,
	lightOffsetPos = 11,
	type = 2,
	disappearEffect = 17,
	skipFinish = 4,
	pos = 14,
	desc = 13,
	roundId = 5,
	param = 3,
	effect = 16,
	starOffsetPos = 10,
	tipOffsetPos = 15,
	res = 6,
	generalType = 9,
	id = 1,
	bonusGroup = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.weekwalk_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_element, "configList", _configList)
	rawset(lua_weekwalk_element, "configDict", _configDict)
end

setmetatable(lua_weekwalk_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_element, "configList", nil)
	rawset(lua_weekwalk_element, "configDict", nil)
end

return lua_weekwalk_element
