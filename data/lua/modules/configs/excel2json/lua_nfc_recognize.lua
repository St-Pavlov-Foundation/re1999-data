-- chunkname: @modules/configs/excel2json/lua_nfc_recognize.lua

module("modules.configs.excel2json.lua_nfc_recognize", package.seeall)

local lua_nfc_recognize = {}
local fields = {
	param = 3,
	unlockId = 5,
	unclaimedId = 6,
	type = 2,
	id = 1,
	notMainTipsId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.nfc_recognize_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_nfc_recognize, "configList", _configList)
	rawset(lua_nfc_recognize, "configDict", _configDict)
end

setmetatable(lua_nfc_recognize, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_nfc_recognize.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_nfc_recognize, "configList", nil)
	rawset(lua_nfc_recognize, "configDict", nil)
end

return lua_nfc_recognize
