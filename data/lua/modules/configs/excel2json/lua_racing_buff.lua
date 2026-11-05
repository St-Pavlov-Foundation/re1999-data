-- chunkname: @modules/configs/excel2json/lua_racing_buff.lua

module("modules.configs.excel2json.lua_racing_buff", package.seeall)

local lua_racing_buff = {}
local fields = {
	kind = 2,
	prefab = 7,
	time = 4,
	anim = 9,
	includeTypes = 5,
	typeId = 3,
	icon = 10,
	camera = 8,
	id = 1,
	features = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.racing_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_buff, "configList", _configList)
	rawset(lua_racing_buff, "configDict", _configDict)
end

setmetatable(lua_racing_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_buff, "configList", nil)
	rawset(lua_racing_buff, "configDict", nil)
end

return lua_racing_buff
