-- chunkname: @modules/configs/excel2json/lua_fight_skin_scale_by_z.lua

module("modules.configs.excel2json.lua_fight_skin_scale_by_z", package.seeall)

local lua_fight_skin_scale_by_z = {}
local fields = {
	posZ = 3,
	priority = 2,
	posXOffset = 5,
	id = 1,
	scale = 4
}
local primaryKey = {
	"id",
	"priority"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skin_scale_by_z_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skin_scale_by_z, "configList", _configList)
	rawset(lua_fight_skin_scale_by_z, "configDict", _configDict)
end

setmetatable(lua_fight_skin_scale_by_z, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skin_scale_by_z.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skin_scale_by_z, "configList", nil)
	rawset(lua_fight_skin_scale_by_z, "configDict", nil)
end

return lua_fight_skin_scale_by_z
