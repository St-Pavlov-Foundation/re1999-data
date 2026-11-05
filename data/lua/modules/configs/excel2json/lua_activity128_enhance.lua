-- chunkname: @modules/configs/excel2json/lua_activity128_enhance.lua

module("modules.configs.excel2json.lua_activity128_enhance", package.seeall)

local lua_activity128_enhance = {}
local fields = {
	sort = 3,
	desc = 5,
	characterId = 2,
	activityId = 1,
	exchangeSkills = 4
}
local primaryKey = {
	"activityId",
	"characterId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity128_enhance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_enhance, "configList", _configList)
	rawset(lua_activity128_enhance, "configDict", _configDict)
end

setmetatable(lua_activity128_enhance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_enhance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_enhance, "configList", nil)
	rawset(lua_activity128_enhance, "configDict", nil)
end

return lua_activity128_enhance
