-- chunkname: @modules/configs/excel2json/lua_activity225_rock_paper_scissors_difficult.lua

module("modules.configs.excel2json.lua_activity225_rock_paper_scissors_difficult", package.seeall)

local lua_activity225_rock_paper_scissors_difficult = {}
local fields = {
	difficulty = 2,
	day = 1
}
local primaryKey = {
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity225_rock_paper_scissors_difficult_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_rock_paper_scissors_difficult, "configList", _configList)
	rawset(lua_activity225_rock_paper_scissors_difficult, "configDict", _configDict)
end

setmetatable(lua_activity225_rock_paper_scissors_difficult, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_rock_paper_scissors_difficult.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_rock_paper_scissors_difficult, "configList", nil)
	rawset(lua_activity225_rock_paper_scissors_difficult, "configDict", nil)
end

return lua_activity225_rock_paper_scissors_difficult
