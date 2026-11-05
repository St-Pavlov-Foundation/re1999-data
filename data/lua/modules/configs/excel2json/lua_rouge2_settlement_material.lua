-- chunkname: @modules/configs/excel2json/lua_rouge2_settlement_material.lua

module("modules.configs.excel2json.lua_rouge2_settlement_material", package.seeall)

local lua_rouge2_settlement_material = {}
local fields = {
	score = 2,
	materialGroup = 4,
	materialNum = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_settlement_material_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_settlement_material, "configList", _configList)
	rawset(lua_rouge2_settlement_material, "configDict", _configDict)
end

setmetatable(lua_rouge2_settlement_material, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_settlement_material.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_settlement_material, "configList", nil)
	rawset(lua_rouge2_settlement_material, "configDict", nil)
end

return lua_rouge2_settlement_material
