-- chunkname: @modules/configs/excel2json/lua_help_page_tab.lua

module("modules.configs.excel2json.lua_help_page_tab", package.seeall)

local lua_help_page_tab = {}
local fields = {
	parentId = 2,
	title_en = 5,
	sortIdx = 3,
	showType = 6,
	id = 1,
	title = 4,
	helpId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_en = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.help_page_tab_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_help_page_tab, "configList", _configList)
	rawset(lua_help_page_tab, "configDict", _configDict)
end

setmetatable(lua_help_page_tab, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_help_page_tab.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_help_page_tab, "configList", nil)
	rawset(lua_help_page_tab, "configDict", nil)
end

return lua_help_page_tab
