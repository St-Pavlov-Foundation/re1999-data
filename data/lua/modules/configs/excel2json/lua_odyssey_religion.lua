-- chunkname: @modules/configs/excel2json/lua_odyssey_religion.lua

module("modules.configs.excel2json.lua_odyssey_religion", package.seeall)

local lua_odyssey_religion = {}
local fields = {
	tips = 7,
	name = 3,
	notExposeName = 6,
	type = 5,
	desc = 4,
	isBoss = 9,
	pos = 8,
	clueList = 2,
	elementId = 10,
	autoExpose = 12,
	id = 1,
	icon = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 5,
	name = 1,
	notExposeName = 4,
	type = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.odyssey_religion_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_religion, "configList", _configList)
	rawset(lua_odyssey_religion, "configDict", _configDict)
end

setmetatable(lua_odyssey_religion, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_religion.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_religion, "configList", nil)
	rawset(lua_odyssey_religion, "configDict", nil)
end

return lua_odyssey_religion
