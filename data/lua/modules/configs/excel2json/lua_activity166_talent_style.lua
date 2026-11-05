-- chunkname: @modules/configs/excel2json/lua_activity166_talent_style.lua

module("modules.configs.excel2json.lua_activity166_talent_style", package.seeall)

local lua_activity166_talent_style = {}
local fields = {
	needStar = 3,
	slot = 6,
	skillId2 = 5,
	skillId = 4,
	talentId = 1,
	level = 2
}
local primaryKey = {
	"talentId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity166_talent_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_talent_style, "configList", _configList)
	rawset(lua_activity166_talent_style, "configDict", _configDict)
end

setmetatable(lua_activity166_talent_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_talent_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_talent_style, "configList", nil)
	rawset(lua_activity166_talent_style, "configDict", nil)
end

return lua_activity166_talent_style
