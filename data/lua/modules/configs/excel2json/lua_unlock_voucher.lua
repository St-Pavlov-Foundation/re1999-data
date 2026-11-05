-- chunkname: @modules/configs/excel2json/lua_unlock_voucher.lua

module("modules.configs.excel2json.lua_unlock_voucher", package.seeall)

local lua_unlock_voucher = {}
local fields = {
	name = 2,
	id = 1,
	icon = 4,
	rare = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.unlock_voucher_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_unlock_voucher, "configList", _configList)
	rawset(lua_unlock_voucher, "configDict", _configDict)
end

setmetatable(lua_unlock_voucher, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_unlock_voucher.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_unlock_voucher, "configList", nil)
	rawset(lua_unlock_voucher, "configDict", nil)
end

return lua_unlock_voucher
