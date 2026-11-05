-- chunkname: @modules/configs/excel2json/lua_survival_disposition.lua

module("modules.configs.excel2json.lua_survival_disposition", package.seeall)

local lua_survival_disposition = {}
local fields = {
	attribute4 = 7,
	attribute3 = 6,
	attribute1 = 4,
	type = 2,
	id = 1,
	attribute2 = 5,
	attribute5 = 8,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_disposition_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_disposition, "configList", _configList)
	rawset(lua_survival_disposition, "configDict", _configDict)
end

setmetatable(lua_survival_disposition, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_disposition.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_disposition, "configList", nil)
	rawset(lua_survival_disposition, "configDict", nil)
end

return lua_survival_disposition
