-- chunkname: @modules/configs/excel2json/lua_bp_update_popup.lua

module("modules.configs.excel2json.lua_bp_update_popup", package.seeall)

local lua_bp_update_popup = {}
local fields = {
	startTime = 2,
	showItem = 5,
	endTime = 3,
	txt = 4,
	popupId = 1
}
local primaryKey = {
	"popupId"
}
local mlStringKey = {
	txt = 1
}
local _configList, _configDict
local configPath = "configs.bp_update_popup_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bp_update_popup, "configList", _configList)
	rawset(lua_bp_update_popup, "configDict", _configDict)
end

setmetatable(lua_bp_update_popup, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bp_update_popup.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bp_update_popup, "configList", nil)
	rawset(lua_bp_update_popup, "configDict", nil)
end

return lua_bp_update_popup
