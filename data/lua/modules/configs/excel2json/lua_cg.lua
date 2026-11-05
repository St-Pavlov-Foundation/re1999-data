-- chunkname: @modules/configs/excel2json/lua_cg.lua

module("modules.configs.excel2json.lua_cg", package.seeall)

local lua_cg = {}
local fields = {
	preCgId = 9,
	name = 4,
	nameEn = 5,
	storyChapterId = 3,
	desc = 6,
	image = 8,
	episodeId = 7,
	herostoryId = 10,
	id = 1,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.cg_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_cg, "configList", _configList)
	rawset(lua_cg, "configDict", _configDict)
end

setmetatable(lua_cg, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_cg.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_cg, "configList", nil)
	rawset(lua_cg, "configDict", nil)
end

return lua_cg
