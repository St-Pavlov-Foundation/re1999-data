-- chunkname: @modules/configs/excel2json/lua_key_block.lua

module("modules.configs.excel2json.lua_key_block", package.seeall)

local lua_key_block = {}
local fields = {
	name = 2,
	hud = 1,
	blockkey = 3
}
local primaryKey = {
	"hud"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.key_block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_key_block, "configList", _configList)
	rawset(lua_key_block, "configDict", _configDict)
end

setmetatable(lua_key_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_key_block.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_key_block, "configList", nil)
	rawset(lua_key_block, "configDict", nil)
end

return lua_key_block
