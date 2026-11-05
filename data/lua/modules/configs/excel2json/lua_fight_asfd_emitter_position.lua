-- chunkname: @modules/configs/excel2json/lua_fight_asfd_emitter_position.lua

module("modules.configs.excel2json.lua_fight_asfd_emitter_position", package.seeall)

local lua_fight_asfd_emitter_position = {}
local fields = {
	sceneId = 1,
	enemySidePos = 4,
	emitterId = 2,
	mySidePos = 3
}
local primaryKey = {
	"sceneId",
	"emitterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_asfd_emitter_position_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_asfd_emitter_position, "configList", _configList)
	rawset(lua_fight_asfd_emitter_position, "configDict", _configDict)
end

setmetatable(lua_fight_asfd_emitter_position, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_asfd_emitter_position.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_asfd_emitter_position, "configList", nil)
	rawset(lua_fight_asfd_emitter_position, "configDict", nil)
end

return lua_fight_asfd_emitter_position
