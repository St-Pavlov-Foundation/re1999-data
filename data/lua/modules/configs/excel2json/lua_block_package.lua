-- chunkname: @modules/configs/excel2json/lua_block_package.lua

module("modules.configs.excel2json.lua_block_package", package.seeall)

local lua_block_package = {}
local fields = {
	blockBuildDegree = 12,
	name = 2,
	useDesc = 3,
	free = 11,
	sources = 10,
	canExchange = 14,
	rare = 7,
	desc = 4,
	showOnly = 13,
	sourcesType = 9,
	id = 1,
	icon = 5,
	rewardIcon = 6,
	nameEn = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.block_package_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_block_package, "configList", _configList)
	rawset(lua_block_package, "configDict", _configDict)
end

setmetatable(lua_block_package, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_package.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_package, "configList", nil)
	rawset(lua_block_package, "configDict", nil)
end

return lua_block_package
