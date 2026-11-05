-- chunkname: @modules/configs/excel2json/lua_guide_mask.lua

module("modules.configs.excel2json.lua_guide_mask", package.seeall)

local lua_guide_mask = {}
local fields = {
	uiOffset1 = 2,
	uiInfo1 = 3,
	uiOffset2 = 5,
	id = 1,
	goPath1 = 4,
	goPath4 = 13,
	uiInfo3 = 9,
	uiInfo4 = 12,
	goPath3 = 10,
	goPath2 = 7,
	uiInfo2 = 6,
	uiOffset3 = 8,
	uiOffset4 = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.guide_mask_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_guide_mask, "configList", _configList)
	rawset(lua_guide_mask, "configDict", _configDict)
end

setmetatable(lua_guide_mask, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_guide_mask.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_guide_mask, "configList", nil)
	rawset(lua_guide_mask, "configDict", nil)
end

return lua_guide_mask
