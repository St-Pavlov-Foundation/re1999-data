-- chunkname: @modules/configs/excel2json/lua_version_res_split.lua

module("modules.configs.excel2json.lua_version_res_split", package.seeall)

local lua_version_res_split = {}
local fields = {
	ignore = 12,
	packName = 11,
	videoPath = 7,
	audio = 2,
	folderPath = 6,
	guide = 4,
	uiFolder = 9,
	story = 5,
	path = 8,
	chapter = 3,
	id = 1,
	uiPath = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.version_res_split_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_version_res_split, "configList", _configList)
	rawset(lua_version_res_split, "configDict", _configDict)
end

setmetatable(lua_version_res_split, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_version_res_split.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_version_res_split, "configList", nil)
	rawset(lua_version_res_split, "configDict", nil)
end

return lua_version_res_split
