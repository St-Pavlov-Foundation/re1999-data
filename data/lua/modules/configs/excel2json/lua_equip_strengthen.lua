-- chunkname: @modules/configs/excel2json/lua_equip_strengthen.lua

module("modules.configs.excel2json.lua_equip_strengthen", package.seeall)

local lua_equip_strengthen = {}
local fields = {
	strengthType = 1,
	def = 4,
	hp = 2,
	atk = 3,
	mdef = 5
}
local primaryKey = {
	"strengthType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_strengthen_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_strengthen, "configList", _configList)
	rawset(lua_equip_strengthen, "configDict", _configDict)
end

setmetatable(lua_equip_strengthen, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_strengthen.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_strengthen, "configList", nil)
	rawset(lua_equip_strengthen, "configDict", nil)
end

return lua_equip_strengthen
