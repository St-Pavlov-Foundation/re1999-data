-- chunkname: @modules/configs/excel2json/lua_special_block.lua

module("modules.configs.excel2json.lua_special_block", package.seeall)

local lua_special_block = {}
local fields = {
	name = 2,
	sources = 8,
	useDesc = 3,
	duplicateItem = 11,
	age = 10,
	rare = 6,
	desc = 4,
	heroId = 9,
	id = 1,
	icon = 5,
	nameEn = 7
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
local configPath = "configs.special_block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_special_block, "configList", _configList)
	rawset(lua_special_block, "configDict", _configDict)
end

setmetatable(lua_special_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_special_block.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_special_block, "configList", nil)
	rawset(lua_special_block, "configDict", nil)
end

return lua_special_block
