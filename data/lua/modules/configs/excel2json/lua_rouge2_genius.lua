-- chunkname: @modules/configs/excel2json/lua_rouge2_genius.lua

module("modules.configs.excel2json.lua_rouge2_genius", package.seeall)

local lua_rouge2_genius = {}
local fields = {
	overviewText = 10,
	name = 2,
	icon = 6,
	talentType = 7,
	replaceId = 4,
	desc = 5,
	effects = 3,
	typeName = 9,
	id = 1,
	talentOrder = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	overviewText = 4,
	name = 1,
	typeName = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_genius_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_genius, "configList", _configList)
	rawset(lua_rouge2_genius, "configDict", _configDict)
end

setmetatable(lua_rouge2_genius, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_genius.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_genius, "configList", nil)
	rawset(lua_rouge2_genius, "configDict", nil)
end

return lua_rouge2_genius
