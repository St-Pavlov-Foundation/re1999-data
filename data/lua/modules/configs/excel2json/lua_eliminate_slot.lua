-- chunkname: @modules/configs/excel2json/lua_eliminate_slot.lua

module("modules.configs.excel2json.lua_eliminate_slot", package.seeall)

local lua_eliminate_slot = {}
local fields = {
	defaultUnlock = 2,
	chessId = 1
}
local primaryKey = {
	"chessId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_slot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_slot, "configList", _configList)
	rawset(lua_eliminate_slot, "configDict", _configDict)
end

setmetatable(lua_eliminate_slot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_slot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_slot, "configList", nil)
	rawset(lua_eliminate_slot, "configDict", nil)
end

return lua_eliminate_slot
