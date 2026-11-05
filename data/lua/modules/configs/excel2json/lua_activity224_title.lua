-- chunkname: @modules/configs/excel2json/lua_activity224_title.lua

module("modules.configs.excel2json.lua_activity224_title", package.seeall)

local lua_activity224_title = {}
local fields = {
	titleId = 1,
	titleBackground = 4,
	titleType = 2,
	titleName = 3
}
local primaryKey = {
	"titleId"
}
local mlStringKey = {
	titleName = 1
}
local _configList, _configDict
local configPath = "configs.activity224_title_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity224_title, "configList", _configList)
	rawset(lua_activity224_title, "configDict", _configDict)
end

setmetatable(lua_activity224_title, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity224_title.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity224_title, "configList", nil)
	rawset(lua_activity224_title, "configDict", nil)
end

return lua_activity224_title
