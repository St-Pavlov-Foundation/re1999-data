-- chunkname: @modules/configs/excel2json/lua_talent_style.lua

module("modules.configs.excel2json.lua_talent_style", package.seeall)

local lua_talent_style = {}
local fields = {
	replaceCube = 4,
	name = 5,
	tagicon = 6,
	tag = 7,
	talentMould = 1,
	styleId = 2,
	color = 8,
	level = 3
}
local primaryKey = {
	"talentMould",
	"styleId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.talent_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_style, "configList", _configList)
	rawset(lua_talent_style, "configDict", _configDict)
end

setmetatable(lua_talent_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_style, "configList", nil)
	rawset(lua_talent_style, "configDict", nil)
end

return lua_talent_style
