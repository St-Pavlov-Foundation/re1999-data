-- chunkname: @modules/configs/excel2json/lua_partygame_guesswho.lua

module("modules.configs.excel2json.lua_partygame_guesswho", package.seeall)

local lua_partygame_guesswho = {}
local fields = {
	openType = 2,
	id = 1,
	answerTime = 4,
	pictureIds = 5,
	answerCount = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_guesswho_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_guesswho, "configList", _configList)
	rawset(lua_partygame_guesswho, "configDict", _configDict)
end

setmetatable(lua_partygame_guesswho, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_guesswho.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_guesswho, "configList", nil)
	rawset(lua_partygame_guesswho, "configDict", nil)
end

return lua_partygame_guesswho
