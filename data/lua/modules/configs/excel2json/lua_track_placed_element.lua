-- chunkname: @modules/configs/excel2json/lua_track_placed_element.lua

module("modules.configs.excel2json.lua_track_placed_element", package.seeall)

local lua_track_placed_element = {}
local fields = {
	elementId = 3,
	isOn = 6,
	distance = 5,
	lane = 4,
	traceId = 1,
	elementUid = 2
}
local primaryKey = {
	"traceId",
	"elementUid"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.track_placed_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_track_placed_element, "configList", _configList)
	rawset(lua_track_placed_element, "configDict", _configDict)
end

setmetatable(lua_track_placed_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_track_placed_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_track_placed_element, "configList", nil)
	rawset(lua_track_placed_element, "configDict", nil)
end

return lua_track_placed_element
