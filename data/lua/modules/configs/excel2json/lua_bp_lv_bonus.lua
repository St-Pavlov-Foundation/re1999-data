-- chunkname: @modules/configs/excel2json/lua_bp_lv_bonus.lua

module("modules.configs.excel2json.lua_bp_lv_bonus", package.seeall)

local lua_bp_lv_bonus = {}
local fields = {
	selfSelectPayItem = 9,
	spFreeBonus = 6,
	selfSelectPayBonus = 8,
	payBonus = 4,
	keyBonus = 5,
	bpId = 1,
	spPayBonus = 7,
	freeBonus = 3,
	level = 2
}
local primaryKey = {
	"bpId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bp_lv_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bp_lv_bonus, "configList", _configList)
	rawset(lua_bp_lv_bonus, "configDict", _configDict)
end

setmetatable(lua_bp_lv_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bp_lv_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bp_lv_bonus, "configList", nil)
	rawset(lua_bp_lv_bonus, "configDict", nil)
end

return lua_bp_lv_bonus
