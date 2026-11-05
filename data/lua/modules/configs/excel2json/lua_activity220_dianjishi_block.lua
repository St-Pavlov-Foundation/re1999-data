-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_block.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_block", package.seeall)

local lua_activity220_dianjishi_block = {}
local fields = {
	value = 5,
	mapId = 1,
	helpOrder = 7,
	type = 3,
	id = 2,
	shape = 4,
	icon = 8,
	rightPos = 6
}
local primaryKey = {
	"mapId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_dianjishi_block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_dianjishi_block, "configList", _configList)
	rawset(lua_activity220_dianjishi_block, "configDict", _configDict)
end

setmetatable(lua_activity220_dianjishi_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_dianjishi_block.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_dianjishi_block, "configList", nil)
	rawset(lua_activity220_dianjishi_block, "configDict", nil)
end

return lua_activity220_dianjishi_block
