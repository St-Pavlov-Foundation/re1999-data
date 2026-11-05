-- chunkname: @modules/configs/excel2json/lua_survival_equip.lua

module("modules.configs.excel2json.lua_survival_equip", package.seeall)

local lua_survival_equip = {}
local fields = {
	score = 4,
	extendCost = 2,
	id = 1,
	effectDesc = 5,
	group = 3,
	desc = 7,
	effect = 9,
	effectDesc2 = 6,
	tag = 8,
	equipType = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 1,
	desc = 3,
	effectDesc2 = 2
}
local _configList, _configDict
local configPath = "configs.survival_equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_equip, "configList", _configList)
	rawset(lua_survival_equip, "configDict", _configDict)
end

setmetatable(lua_survival_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_equip, "configList", nil)
	rawset(lua_survival_equip, "configDict", nil)
end

return lua_survival_equip
