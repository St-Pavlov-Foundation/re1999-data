-- chunkname: @modules/configs/excel2json/lua_character_limited.lua

module("modules.configs.excel2json.lua_character_limited", package.seeall)

local lua_character_limited = {}
local fields = {
	spine = 2,
	mvtime = 5,
	spineParam = 3,
	entranceMv = 4,
	voice = 6,
	characterVoice = 14,
	stopAudio = 11,
	storeMv = 15,
	storeMvAudio = 16,
	entranceEffect = 8,
	specialLive2d = 13,
	audio = 10,
	actionTime = 7,
	specialInsightDesc = 12,
	effectDuration = 9,
	storeMvStopAudio = 17,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	specialInsightDesc = 1
}
local _configList, _configDict
local configPath = "configs.character_limited_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_limited, "configList", _configList)
	rawset(lua_character_limited, "configDict", _configDict)
end

setmetatable(lua_character_limited, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_limited.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_limited, "configList", nil)
	rawset(lua_character_limited, "configDict", nil)
end

return lua_character_limited
