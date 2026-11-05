-- chunkname: @modules/configs/excel2json/lua_talent_style_cost.lua

module("modules.configs.excel2json.lua_talent_style_cost", package.seeall)

local lua_talent_style_cost = {}
local fields = {
	styleId = 2,
	heroId = 1,
	consume = 3
}
local primaryKey = {
	"heroId",
	"styleId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_style_cost_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_style_cost, "configList", _configList)
	rawset(lua_talent_style_cost, "configDict", _configDict)
end

setmetatable(lua_talent_style_cost, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_style_cost.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_style_cost, "configList", nil)
	rawset(lua_talent_style_cost, "configDict", nil)
end

return lua_talent_style_cost
