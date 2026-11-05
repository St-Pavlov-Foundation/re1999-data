-- chunkname: @modules/configs/excel2json/lua_racing_ultimate.lua

module("modules.configs.excel2json.lua_racing_ultimate", package.seeall)

local lua_racing_ultimate = {}
local fields = {
	energyType = 6,
	effect = 4,
	name = 3,
	live2DAnimation = 7,
	id = 1,
	racer = 2,
	energy = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.racing_ultimate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_ultimate, "configList", _configList)
	rawset(lua_racing_ultimate, "configDict", _configDict)
end

setmetatable(lua_racing_ultimate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_ultimate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_ultimate, "configList", nil)
	rawset(lua_racing_ultimate, "configDict", nil)
end

return lua_racing_ultimate
