-- chunkname: @modules/configs/excel2json/lua_activity248_slot.lua

module("modules.configs.excel2json.lua_activity248_slot", package.seeall)

local lua_activity248_slot = {}
local fields = {
	clueText = 5,
	pileId = 2,
	tip = 6,
	clueId = 4,
	id = 1,
	isAutoFill = 7,
	tagId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tip = 2,
	clueText = 1
}
local _configList, _configDict
local configPath = "configs.activity248_slot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity248_slot, "configList", _configList)
	rawset(lua_activity248_slot, "configDict", _configDict)
end

setmetatable(lua_activity248_slot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity248_slot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity248_slot, "configList", nil)
	rawset(lua_activity248_slot, "configDict", nil)
end

return lua_activity248_slot
