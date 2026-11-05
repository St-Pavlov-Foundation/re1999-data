-- chunkname: @modules/configs/excel2json/lua_monster_guide_focus.lua

module("modules.configs.excel2json.lua_monster_guide_focus", package.seeall)

local lua_monster_guide_focus = {}
local fields = {
	param = 3,
	invokeType = 2,
	completeWithGroup = 5,
	isActivityVersion = 7,
	id = 1,
	icon = 6,
	monster = 4,
	des = 8
}
local primaryKey = {
	"id",
	"invokeType",
	"param",
	"monster"
}
local mlStringKey = {
	des = 1
}
local _configList, _configDict
local configPath = "configs.monster_guide_focus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_guide_focus, "configList", _configList)
	rawset(lua_monster_guide_focus, "configDict", _configDict)
end

setmetatable(lua_monster_guide_focus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_guide_focus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_guide_focus, "configList", nil)
	rawset(lua_monster_guide_focus, "configDict", nil)
end

return lua_monster_guide_focus
