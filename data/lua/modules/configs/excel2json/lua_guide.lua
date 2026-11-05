-- chunkname: @modules/configs/excel2json/lua_guide.lua

module("modules.configs.excel2json.lua_guide", package.seeall)

local lua_guide = {}
local fields = {
	id = 1,
	priority = 7,
	isOnline = 3,
	trigger = 4,
	desc = 2,
	invalid = 5,
	parallel = 8,
	restart = 9,
	interruptFinish = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.guide_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_guide, "configList", _configList)
	rawset(lua_guide, "configDict", _configDict)
end

setmetatable(lua_guide, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_guide.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_guide, "configList", nil)
	rawset(lua_guide, "configDict", nil)
end

return lua_guide
