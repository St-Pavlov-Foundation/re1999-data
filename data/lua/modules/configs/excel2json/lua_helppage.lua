-- chunkname: @modules/configs/excel2json/lua_helppage.lua

module("modules.configs.excel2json.lua_helppage", package.seeall)

local lua_helppage = {}
local fields = {
	text = 4,
	icon = 5,
	unlockGuideId = 7,
	type = 3,
	id = 1,
	title = 2,
	isCn = 8,
	iconText = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.helppage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_helppage, "configList", _configList)
	rawset(lua_helppage, "configDict", _configDict)
end

setmetatable(lua_helppage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_helppage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_helppage, "configList", nil)
	rawset(lua_helppage, "configDict", nil)
end

return lua_helppage
