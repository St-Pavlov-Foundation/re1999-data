-- chunkname: @modules/configs/excel2json/lua_survival_end.lua

module("modules.configs.excel2json.lua_survival_end", package.seeall)

local lua_survival_end = {}
local fields = {
	endImg = 7,
	name = 2,
	mainImg = 9,
	type = 3,
	group = 4,
	unlock = 6,
	endDesc = 5,
	id = 1,
	order = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_end_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_end, "configList", _configList)
	rawset(lua_survival_end, "configDict", _configDict)
end

setmetatable(lua_survival_end, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_end.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_end, "configList", nil)
	rawset(lua_survival_end, "configDict", nil)
end

return lua_survival_end
