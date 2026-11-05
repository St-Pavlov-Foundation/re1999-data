-- chunkname: @modules/configs/excel2json/lua_activity166_base.lua

module("modules.configs.excel2json.lua_activity166_base", package.seeall)

local lua_activity166_base = {}
local fields = {
	talentId = 4,
	name = 5,
	desc = 6,
	level = 7,
	baseId = 2,
	strategy = 8,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"baseId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity166_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_base, "configList", _configList)
	rawset(lua_activity166_base, "configDict", _configDict)
end

setmetatable(lua_activity166_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_base, "configList", nil)
	rawset(lua_activity166_base, "configDict", nil)
end

return lua_activity166_base
