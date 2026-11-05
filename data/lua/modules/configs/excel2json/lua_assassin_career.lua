-- chunkname: @modules/configs/excel2json/lua_assassin_career.lua

module("modules.configs.excel2json.lua_assassin_career", package.seeall)

local lua_assassin_career = {}
local fields = {
	equipName = 3,
	pic = 6,
	capacity = 4,
	attrs = 5,
	title = 2,
	careerId = 1
}
local primaryKey = {
	"careerId"
}
local mlStringKey = {
	equipName = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.assassin_career_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_career, "configList", _configList)
	rawset(lua_assassin_career, "configDict", _configDict)
end

setmetatable(lua_assassin_career, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_career.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_career, "configList", nil)
	rawset(lua_assassin_career, "configDict", nil)
end

return lua_assassin_career
