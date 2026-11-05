-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_result.lua

module("modules.configs.excel2json.lua_v3a2_chapter_result", package.seeall)

local lua_v3a2_chapter_result = {}
local fields = {
	res = 3,
	option = 5,
	id = 1,
	title = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.v3a2_chapter_result_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a2_chapter_result, "configList", _configList)
	rawset(lua_v3a2_chapter_result, "configDict", _configDict)
end

setmetatable(lua_v3a2_chapter_result, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a2_chapter_result.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a2_chapter_result, "configList", nil)
	rawset(lua_v3a2_chapter_result, "configDict", nil)
end

return lua_v3a2_chapter_result
