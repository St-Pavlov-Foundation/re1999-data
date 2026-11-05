-- chunkname: @modules/configs/excel2json/lua_stance.lua

module("modules.configs.excel2json.lua_stance", package.seeall)

local lua_stance = {}
local fields = {
	pos8 = 9,
	pos1 = 2,
	subPos1 = 10,
	pos5 = 6,
	subPos2 = 11,
	subPos3 = 12,
	pos4 = 5,
	dec_stance = 13,
	pos3 = 4,
	cardCamera = 14,
	pos7 = 8,
	pos2 = 3,
	id = 1,
	pos6 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stance, "configList", _configList)
	rawset(lua_stance, "configDict", _configDict)
end

setmetatable(lua_stance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stance, "configList", nil)
	rawset(lua_stance, "configDict", nil)
end

return lua_stance
