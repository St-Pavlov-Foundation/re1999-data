-- chunkname: @modules/configs/excel2json/lua_critter_rare.lua

module("modules.configs.excel2json.lua_critter_rare", package.seeall)

local lua_critter_rare = {}
local fields = {
	cardRes = 2,
	incubateCost = 4,
	rare = 1,
	eggRes = 3
}
local primaryKey = {
	"rare"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_rare_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_rare, "configList", _configList)
	rawset(lua_critter_rare, "configDict", _configDict)
end

setmetatable(lua_critter_rare, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_rare.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_rare, "configList", nil)
	rawset(lua_critter_rare, "configDict", nil)
end

return lua_critter_rare
