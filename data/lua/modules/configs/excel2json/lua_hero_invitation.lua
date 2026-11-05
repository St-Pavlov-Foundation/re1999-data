-- chunkname: @modules/configs/excel2json/lua_hero_invitation.lua

module("modules.configs.excel2json.lua_hero_invitation", package.seeall)

local lua_hero_invitation = {}
local fields = {
	head = 3,
	rewardDisplayList = 4,
	name = 2,
	storyId = 6,
	id = 1,
	elementId = 5,
	restoryId = 7,
	openTime = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_invitation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_invitation, "configList", _configList)
	rawset(lua_hero_invitation, "configDict", _configDict)
end

setmetatable(lua_hero_invitation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_invitation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_invitation, "configList", nil)
	rawset(lua_hero_invitation, "configDict", nil)
end

return lua_hero_invitation
