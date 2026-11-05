-- chunkname: @modules/configs/excel2json/lua_toast.lua

module("modules.configs.excel2json.lua_toast", package.seeall)

local lua_toast = {}
local fields = {
	audioId = 4,
	tips = 2,
	notMerge = 5,
	notShow = 6,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}
local _configList, _configDict
local configPath = "configs.toast_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_toast, "configList", _configList)
	rawset(lua_toast, "configDict", _configDict)
end

setmetatable(lua_toast, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_toast.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_toast, "configList", nil)
	rawset(lua_toast, "configDict", nil)
end

return lua_toast
