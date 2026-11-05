-- chunkname: @modules/configs/excel2json/lua_atomic_drag_element_toast.lua

module("modules.configs.excel2json.lua_atomic_drag_element_toast", package.seeall)

local lua_atomic_drag_element_toast = {}
local fields = {
	id = 1,
	toast = 3,
	targetId = 2
}
local primaryKey = {
	"id",
	"targetId"
}
local mlStringKey = {
	toast = 1
}
local _configList, _configDict
local configPath = "configs.atomic_drag_element_toast_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_drag_element_toast, "configList", _configList)
	rawset(lua_atomic_drag_element_toast, "configDict", _configDict)
end

setmetatable(lua_atomic_drag_element_toast, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_drag_element_toast.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_drag_element_toast, "configList", nil)
	rawset(lua_atomic_drag_element_toast, "configDict", nil)
end

return lua_atomic_drag_element_toast
