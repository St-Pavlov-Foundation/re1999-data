-- chunkname: @modules/configs/excel2json/lua_vote.lua

module("modules.configs.excel2json.lua_vote", package.seeall)

local lua_vote = {}
local fields = {
	bindActivityIds = 3,
	isOnline = 2,
	voteId = 1
}
local primaryKey = {
	"voteId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.vote_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_vote, "configList", _configList)
	rawset(lua_vote, "configDict", _configDict)
end

setmetatable(lua_vote, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_vote.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_vote, "configList", nil)
	rawset(lua_vote, "configDict", nil)
end

return lua_vote
