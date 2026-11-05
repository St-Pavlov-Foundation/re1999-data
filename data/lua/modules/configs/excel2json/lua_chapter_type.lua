-- chunkname: @modules/configs/excel2json/lua_chapter_type.lua

module("modules.configs.excel2json.lua_chapter_type", package.seeall)

local lua_chapter_type = {}
local fields = {
	name = 2,
	typeId = 1,
	nameEn = 3
}
local primaryKey = {
	"typeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.chapter_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_type, "configList", _configList)
	rawset(lua_chapter_type, "configDict", _configDict)
end

setmetatable(lua_chapter_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_type, "configList", nil)
	rawset(lua_chapter_type, "configDict", nil)
end

return lua_chapter_type
