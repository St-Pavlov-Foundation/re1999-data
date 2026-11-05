-- chunkname: @modules/configs/excel2json/lua_bbs_dialog.lua

module("modules.configs.excel2json.lua_bbs_dialog", package.seeall)

local lua_bbs_dialog = {}
local fields = {
	audioId = 4,
	text = 5,
	tipsDir = 6,
	delay = 7,
	id = 1,
	icon = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.bbs_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bbs_dialog, "configList", _configList)
	rawset(lua_bbs_dialog, "configDict", _configDict)
end

setmetatable(lua_bbs_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bbs_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bbs_dialog, "configList", nil)
	rawset(lua_bbs_dialog, "configDict", nil)
end

return lua_bbs_dialog
