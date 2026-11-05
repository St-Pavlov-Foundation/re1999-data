-- chunkname: @modules/configs/excel2json/lua_activity166_teach.lua

module("modules.configs.excel2json.lua_activity166_teach", package.seeall)

local lua_activity166_teach = {}
local fields = {
	episodeId = 3,
	name = 5,
	desc = 6,
	strategy = 7,
	teachId = 1,
	firstBonus = 4,
	preTeachId = 2
}
local primaryKey = {
	"teachId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity166_teach_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_teach, "configList", _configList)
	rawset(lua_activity166_teach, "configDict", _configDict)
end

setmetatable(lua_activity166_teach, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_teach.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_teach, "configList", nil)
	rawset(lua_activity166_teach, "configDict", nil)
end

return lua_activity166_teach
