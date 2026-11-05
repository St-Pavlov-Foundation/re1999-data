-- chunkname: @modules/configs/excel2json/lua_mail.lua

module("modules.configs.excel2json.lua_mail", package.seeall)

local lua_mail = {}
local fields = {
	jump = 13,
	locked = 16,
	sender = 3,
	type = 2,
	attachment = 6,
	title = 4,
	addressee = 8,
	copy = 9,
	specialTag = 11,
	content = 5,
	image = 14,
	jumpTitle = 12,
	id = 1,
	icon = 10,
	senderType = 15,
	needShowToast = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 3,
	title = 2,
	jumpTitle = 6,
	copy = 5,
	sender = 1,
	addressee = 4
}
local _configList, _configDict
local configPath = "configs.mail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_mail, "configList", _configList)
	rawset(lua_mail, "configDict", _configDict)
end

setmetatable(lua_mail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_mail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_mail, "configList", nil)
	rawset(lua_mail, "configDict", nil)
end

return lua_mail
