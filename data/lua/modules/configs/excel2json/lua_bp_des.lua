-- chunkname: @modules/configs/excel2json/lua_bp_des.lua

module("modules.configs.excel2json.lua_bp_des", package.seeall)

local lua_bp_des = {}
local fields = {
	tagType = 6,
	iconType = 4,
	iconDesc = 10,
	type = 3,
	des = 9,
	items = 5,
	bpId = 2,
	id = 1,
	icon = 8,
	tagTxt = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	iconDesc = 3,
	tagTxt = 1
}
local _configList, _configDict
local configPath = "configs.bp_des_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bp_des, "configList", _configList)
	rawset(lua_bp_des, "configDict", _configDict)
end

setmetatable(lua_bp_des, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bp_des.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bp_des, "configList", nil)
	rawset(lua_bp_des, "configDict", nil)
end

return lua_bp_des
