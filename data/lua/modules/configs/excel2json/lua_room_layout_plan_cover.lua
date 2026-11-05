-- chunkname: @modules/configs/excel2json/lua_room_layout_plan_cover.lua

module("modules.configs.excel2json.lua_room_layout_plan_cover", package.seeall)

local lua_room_layout_plan_cover = {}
local fields = {
	id = 1,
	name = 2,
	coverResPath = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.room_layout_plan_cover_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_layout_plan_cover, "configList", _configList)
	rawset(lua_room_layout_plan_cover, "configDict", _configDict)
end

setmetatable(lua_room_layout_plan_cover, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_layout_plan_cover.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_layout_plan_cover, "configList", nil)
	rawset(lua_room_layout_plan_cover, "configDict", nil)
end

return lua_room_layout_plan_cover
