-- chunkname: @modules/configs/excel2json/lua_activity220_deleike.lua

module("modules.configs.excel2json.lua_activity220_deleike", package.seeall)

local lua_activity220_deleike = {}
local fields = {
	mapJson = 4,
	mapBg = 3,
	targetDesc = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity220_deleike_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_deleike, "configList", _configList)
	rawset(lua_activity220_deleike, "configDict", _configDict)
end

setmetatable(lua_activity220_deleike, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_deleike.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_deleike, "configList", nil)
	rawset(lua_activity220_deleike, "configDict", nil)
end

return lua_activity220_deleike
