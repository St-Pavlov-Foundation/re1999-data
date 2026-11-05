-- chunkname: @modules/configs/excel2json/lua_toughnessskill.lua

module("modules.configs.excel2json.lua_toughnessskill", package.seeall)

local lua_toughnessskill = {}
local fields = {
	iconBreak = 5,
	passiveSkill = 2,
	toughnessskill = 1,
	iconNormal = 4,
	cdBuff = 3
}
local primaryKey = {
	"toughnessskill"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.toughnessskill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_toughnessskill, "configList", _configList)
	rawset(lua_toughnessskill, "configDict", _configDict)
end

setmetatable(lua_toughnessskill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_toughnessskill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_toughnessskill, "configList", nil)
	rawset(lua_toughnessskill, "configDict", nil)
end

return lua_toughnessskill
