-- chunkname: @modules/configs/excel2json/lua_odyssey_myth.lua

module("modules.configs.excel2json.lua_odyssey_myth", package.seeall)

local lua_odyssey_myth = {}
local fields = {
	elementId = 4,
	res = 3,
	name = 2,
	pos = 6,
	id = 1,
	unlockMap = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_myth_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_myth, "configList", _configList)
	rawset(lua_odyssey_myth, "configDict", _configDict)
end

setmetatable(lua_odyssey_myth, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_myth.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_myth, "configList", nil)
	rawset(lua_odyssey_myth, "configDict", nil)
end

return lua_odyssey_myth
