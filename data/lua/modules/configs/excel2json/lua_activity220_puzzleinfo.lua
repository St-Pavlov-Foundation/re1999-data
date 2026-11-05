-- chunkname: @modules/configs/excel2json/lua_activity220_puzzleinfo.lua

module("modules.configs.excel2json.lua_activity220_puzzleinfo", package.seeall)

local lua_activity220_puzzleinfo = {}
local fields = {
	img = 2,
	fragment = 1
}
local primaryKey = {
	"fragment"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_puzzleinfo_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_puzzleinfo, "configList", _configList)
	rawset(lua_activity220_puzzleinfo, "configDict", _configDict)
end

setmetatable(lua_activity220_puzzleinfo, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_puzzleinfo.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_puzzleinfo, "configList", nil)
	rawset(lua_activity220_puzzleinfo, "configDict", nil)
end

return lua_activity220_puzzleinfo
