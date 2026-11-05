-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/ArcadeSurvivorEntityBTBlackboard.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.ArcadeSurvivorEntityBTBlackboard", package.seeall)

local ArcadeSurvivorEntityBTBlackboard = class("ArcadeSurvivorEntityBTBlackboard")

function ArcadeSurvivorEntityBTBlackboard:ctor(mo)
	self._mo = mo

	self:clearAllVar()
end

function ArcadeSurvivorEntityBTBlackboard:_initVarDict()
	self._varDict = {}

	for _, varName in pairs(ArcadeSurvivorGameEnum.BTVarName) do
		local defaultVal = ArcadeSurvivorGameEnum.DefaultBTVarVal[varName]

		if defaultVal ~= nil then
			self._varDict[varName] = defaultVal
		end
	end
end

function ArcadeSurvivorEntityBTBlackboard:_isValidKey(key)
	if ArcadeSurvivorGameEnum.BTVarName[key] then
		return true
	end

	logError(string.format("ArcadeSurvivorEntityBTBlackboard:_isValidKey error, key is not registered in BTVarName, key:%s", tostring(key)))

	return false
end

function ArcadeSurvivorEntityBTBlackboard:setVar(key, value)
	local isValid = self:_isValidKey(key)

	if not isValid then
		return
	end

	if value == nil then
		self:clearVar(key)

		return
	end

	self._varDict[key] = value
	self._version = self._version + 1
end

function ArcadeSurvivorEntityBTBlackboard:getMO()
	return self._mo
end

function ArcadeSurvivorEntityBTBlackboard:getVersion()
	return self._version
end

function ArcadeSurvivorEntityBTBlackboard:getValue(params)
	local key

	if type(params) == "table" then
		key = params.key
	end

	if not key then
		return params
	end

	local unitGetter = ArcadeSurvivorGameHelper.UnitDataGetterDict[key]

	if unitGetter then
		return unitGetter(self._mo, params.args)
	end

	local globalGetter = ArcadeSurvivorGameHelper.GlobalDataGetterDict[key]

	if globalGetter then
		return globalGetter(params.args)
	end

	return self:getVar(key)
end

function ArcadeSurvivorEntityBTBlackboard:getVar(key)
	local isValid = self:_isValidKey(key)

	if not isValid then
		return nil
	end

	return self._varDict[key]
end

function ArcadeSurvivorEntityBTBlackboard:clearVar(key)
	local isValid = self:_isValidKey(key)

	if not isValid then
		return
	end

	local currentVal = self._varDict[key]
	local defaultVal = ArcadeSurvivorGameEnum.DefaultBTVarVal[key]

	if defaultVal ~= nil then
		if currentVal ~= defaultVal then
			self._varDict[key] = defaultVal
			self._version = self._version + 1
		end

		return
	end

	if currentVal ~= nil then
		self._varDict[key] = nil
		self._version = self._version + 1
	end
end

function ArcadeSurvivorEntityBTBlackboard:clearAllVar()
	self:_initVarDict()

	self._version = 0
end

return ArcadeSurvivorEntityBTBlackboard
