-- chunkname: @modules/configs/excel2json/lua_copost_bonus.lua

module("modules.configs.excel2json.lua_copost_bonus", package.seeall)

local lua_copost_bonus = {}
local fields = {
	isBig = 5,
	versionId = 4,
	pointNum = 3,
	id = 1,
	bonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_bonus, "configList", _configList)
	rawset(lua_copost_bonus, "configDict", _configDict)
end

setmetatable(lua_copost_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_bonus, "configList", nil)
	rawset(lua_copost_bonus, "configDict", nil)
end

return lua_copost_bonus
