-- chunkname: @modules/configs/excel2json/lua_pat_face.lua

module("modules.configs.excel2json.lua_pat_face", package.seeall)

local lua_pat_face = {}
local fields = {
	patFaceOrder = 5,
	patFaceStoryId = 4,
	id = 1,
	patFaceViewName = 3,
	patFaceActivityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.pat_face_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_pat_face, "configList", _configList)
	rawset(lua_pat_face, "configDict", _configDict)
end

setmetatable(lua_pat_face, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_pat_face.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_pat_face, "configList", nil)
	rawset(lua_pat_face, "configDict", nil)
end

return lua_pat_face
