-- chunkname: @modules/configs/excel2json/lua_character_motion_cut.lua

module("modules.configs.excel2json.lua_character_motion_cut", package.seeall)

local lua_character_motion_cut = {}
local fields = {
	onlyStopCut = 4,
	heroId = 1,
	motion = 3,
	skinId = 2
}
local primaryKey = {
	"heroId",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_motion_cut_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_motion_cut, "configList", _configList)
	rawset(lua_character_motion_cut, "configDict", _configDict)
end

setmetatable(lua_character_motion_cut, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_motion_cut.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_motion_cut, "configList", nil)
	rawset(lua_character_motion_cut, "configDict", nil)
end

return lua_character_motion_cut
