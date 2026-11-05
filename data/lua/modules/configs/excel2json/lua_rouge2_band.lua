-- chunkname: @modules/configs/excel2json/lua_rouge2_band.lua

module("modules.configs.excel2json.lua_rouge2_band", package.seeall)

local lua_rouge2_band = {}
local fields = {
	cost = 3,
	name = 2,
	id = 1,
	icon = 4,
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
local configPath = "configs.rouge2_band_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_band, "configList", _configList)
	rawset(lua_rouge2_band, "configDict", _configDict)
end

setmetatable(lua_rouge2_band, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_band.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_band, "configList", nil)
	rawset(lua_rouge2_band, "configDict", nil)
end

return lua_rouge2_band
