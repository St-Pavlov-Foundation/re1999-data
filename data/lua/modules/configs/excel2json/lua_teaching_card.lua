-- chunkname: @modules/configs/excel2json/lua_teaching_card.lua

module("modules.configs.excel2json.lua_teaching_card", package.seeall)

local lua_teaching_card = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.teaching_card_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_teaching_card, "configList", _configList)
	rawset(lua_teaching_card, "configDict", _configDict)
end

setmetatable(lua_teaching_card, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_teaching_card.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_teaching_card, "configList", nil)
	rawset(lua_teaching_card, "configDict", nil)
end

return lua_teaching_card
