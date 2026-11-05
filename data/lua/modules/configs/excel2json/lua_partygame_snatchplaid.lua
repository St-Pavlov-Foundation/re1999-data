-- chunkname: @modules/configs/excel2json/lua_partygame_snatchplaid.lua

module("modules.configs.excel2json.lua_partygame_snatchplaid", package.seeall)

local lua_partygame_snatchplaid = {}
local fields = {
	showNum = 8,
	showCount = 7,
	answerTime = 5,
	stopTime = 4,
	settleTime = 6,
	num = 2,
	round = 1,
	showTime = 3
}
local primaryKey = {
	"round"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_snatchplaid_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_snatchplaid, "configList", _configList)
	rawset(lua_partygame_snatchplaid, "configDict", _configDict)
end

setmetatable(lua_partygame_snatchplaid, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_snatchplaid.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_snatchplaid, "configList", nil)
	rawset(lua_partygame_snatchplaid, "configDict", nil)
end

return lua_partygame_snatchplaid
