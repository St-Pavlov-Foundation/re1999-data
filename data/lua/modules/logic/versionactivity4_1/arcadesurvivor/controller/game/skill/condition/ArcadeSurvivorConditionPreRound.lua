-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/condition/ArcadeSurvivorConditionPreRound.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.condition.ArcadeSurvivorConditionPreRound", package.seeall)

local ArcadeSurvivorConditionPreRound = class("ArcadeSurvivorConditionPreRound", ArcadeSurvivorGameBaseCond)

function ArcadeSurvivorConditionPreRound:onCtor(param)
	local paramArr = string.split(param, "#")

	if paramArr then
		self._initRound = tonumber(paramArr[1])
		self._interval = tonumber(paramArr[2])
	end

	self._lastTriggerRound = nil
end

function ArcadeSurvivorConditionPreRound:_onIsCondSuccess(context)
	if not self._initRound or not self._interval then
		return false
	end

	local model = ArcadeSurvivorGameModel.instance
	local stageIndex = model:getCurStageIndex()
	local levelIndex = model:getCurLevelIndex()

	if self._lastStageIndex ~= stageIndex or self._lastLevelIndex ~= levelIndex then
		self._lastTriggerRound = nil
		self._lastStageIndex = stageIndex
		self._lastLevelIndex = levelIndex
	end

	local curRound = model:getCurRound()

	if curRound < self._initRound then
		return false
	end

	if not self._lastTriggerRound or curRound - self._lastTriggerRound >= self._interval then
		self._lastTriggerRound = curRound

		return true
	end

	return false
end

return ArcadeSurvivorConditionPreRound
