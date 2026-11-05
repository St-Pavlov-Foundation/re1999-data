-- chunkname: @modules/configs/excel2json/lua_turnback_submodule.lua

module("modules.configs.excel2json.lua_turnback_submodule", package.seeall)

local lua_turnback_submodule = {}
local fields = {
	jumpId = 7,
	name = 3,
	reddotId = 8,
	actDesc = 5,
	id = 1,
	turnbackId = 2,
	showInPopup = 6,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	actDesc = 3,
	name = 1,
	nameEn = 2
}
local _configList, _configDict
local configPath = "configs.turnback_submodule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_submodule, "configList", _configList)
	rawset(lua_turnback_submodule, "configDict", _configDict)
end

setmetatable(lua_turnback_submodule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_submodule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_submodule, "configList", nil)
	rawset(lua_turnback_submodule, "configDict", nil)
end

return lua_turnback_submodule
