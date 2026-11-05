-- chunkname: @modules/configs/excel2json/lua_auto_chess_buff.lua

module("modules.configs.excel2json.lua_auto_chess_buff", package.seeall)

local lua_auto_chess_buff = {}
local fields = {
	durationDeduction = 7,
	effect = 4,
	triggerPoint = 3,
	type = 5,
	buffeffectID = 8,
	condition = 2,
	id = 1,
	cover = 6,
	downline = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_buff, "configList", _configList)
	rawset(lua_auto_chess_buff, "configDict", _configDict)
end

setmetatable(lua_auto_chess_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_buff, "configList", nil)
	rawset(lua_auto_chess_buff, "configDict", nil)
end

return lua_auto_chess_buff
