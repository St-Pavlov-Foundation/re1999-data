-- chunkname: @modules/configs/excel2json/lua_equip_chapter.lua

module("modules.configs.excel2json.lua_equip_chapter", package.seeall)

local lua_equip_chapter = {}
local fields = {
	id = 1,
	episodeList = 4,
	difficulty = 2,
	group = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_chapter, "configList", _configList)
	rawset(lua_equip_chapter, "configDict", _configDict)
end

setmetatable(lua_equip_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_chapter, "configList", nil)
	rawset(lua_equip_chapter, "configDict", nil)
end

return lua_equip_chapter
