-- chunkname: @modules/configs/excel2json/lua_activity176_dogtag.lua

module("modules.configs.excel2json.lua_activity176_dogtag", package.seeall)

local lua_activity176_dogtag = {}
local fields = {
	content4 = 6,
	content2 = 4,
	id = 2,
	content1 = 3,
	activityId = 1,
	content3 = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	content2 = 2,
	content1 = 1,
	content4 = 4,
	content3 = 3
}
local _configList, _configDict
local configPath = "configs.activity176_dogtag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity176_dogtag, "configList", _configList)
	rawset(lua_activity176_dogtag, "configDict", _configDict)
end

setmetatable(lua_activity176_dogtag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity176_dogtag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity176_dogtag, "configList", nil)
	rawset(lua_activity176_dogtag, "configDict", nil)
end

return lua_activity176_dogtag
