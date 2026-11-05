-- chunkname: @modules/configs/excel2json/lua_rouge2_material.lua

module("modules.configs.excel2json.lua_rouge2_material", package.seeall)

local lua_rouge2_material = {}
local fields = {
	name = 4,
	details = 6,
	type = 2,
	rare = 3,
	effects = 8,
	numMax = 9,
	formula = 7,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	details = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_material_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_material, "configList", _configList)
	rawset(lua_rouge2_material, "configDict", _configDict)
end

setmetatable(lua_rouge2_material, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_material.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_material, "configList", nil)
	rawset(lua_rouge2_material, "configDict", nil)
end

return lua_rouge2_material
