-- chunkname: @modules/configs/excel2json/lua_skin_ui_bloom.lua

module("modules.configs.excel2json.lua_skin_ui_bloom", package.seeall)

local lua_skin_ui_bloom = {}
local fields = {
	id = 1,
	view_CharacterDataView = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_ui_bloom_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_ui_bloom, "configList", _configList)
	rawset(lua_skin_ui_bloom, "configDict", _configDict)
end

setmetatable(lua_skin_ui_bloom, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_ui_bloom.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_ui_bloom, "configList", nil)
	rawset(lua_skin_ui_bloom, "configDict", nil)
end

return lua_skin_ui_bloom
