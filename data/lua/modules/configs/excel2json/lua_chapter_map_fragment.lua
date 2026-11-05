-- chunkname: @modules/configs/excel2json/lua_chapter_map_fragment.lua

module("modules.configs.excel2json.lua_chapter_map_fragment", package.seeall)

local lua_chapter_map_fragment = {}
local fields = {
	toastId = 6,
	res = 3,
	type = 4,
	id = 1,
	title = 2,
	content = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.chapter_map_fragment_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map_fragment, "configList", _configList)
	rawset(lua_chapter_map_fragment, "configDict", _configDict)
end

setmetatable(lua_chapter_map_fragment, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map_fragment.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map_fragment, "configList", nil)
	rawset(lua_chapter_map_fragment, "configDict", nil)
end

return lua_chapter_map_fragment
