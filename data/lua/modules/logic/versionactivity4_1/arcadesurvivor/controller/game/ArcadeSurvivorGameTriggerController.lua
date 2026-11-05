-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/ArcadeSurvivorGameTriggerController.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.ArcadeSurvivorGameTriggerController", package.seeall)

local ArcadeSurvivorGameTriggerController = class("ArcadeSurvivorGameTriggerController", BaseController)

function ArcadeSurvivorGameTriggerController:onInit()
	self:reInit()
end

function ArcadeSurvivorGameTriggerController:onInitFinish()
	return
end

function ArcadeSurvivorGameTriggerController:addConstEvents()
	return
end

function ArcadeSurvivorGameTriggerController:reInit()
	self._outSizeMaxSkillIdList = {}
	self._outSizeMaxSkillIdDict = {}

	self:clearTriggerChain()
	self:resetTriggerCount()
end

function ArcadeSurvivorGameTriggerController:resetTriggerCount()
	if self._outSizeMaxSkillIdList and #self._outSizeMaxSkillIdList > 0 then
		logError(string.format("ArcadeSurvivorGameTriggerController:【街机幸存者】回合累计触发技能效果已达上限===(%s/%s) 超出技能效果列表:%s", self._triggerCount, ArcadeSurvivorGameEnum.Const.MaxSkillTriggerCount, table.concat(self._outSizeMaxSkillIdList, "\n")))

		self._outSizeMaxSkillIdList = {}
		self._outSizeMaxSkillIdDict = {}
	end

	self._triggerCount = 0
end

function ArcadeSurvivorGameTriggerController:clearTriggerChain()
	self._activeTriggerChainDict = {}
end

function ArcadeSurvivorGameTriggerController:checkTriggerCount(skillId, effectId)
	self._triggerCount = (self._triggerCount or 0) + 1

	if self._triggerCount <= ArcadeSurvivorGameEnum.Const.MaxSkillTriggerCount then
		return false
	end

	local skillKey = string.format("skillId:%s effectId:%s", tostring(skillId), tostring(effectId))

	if not self._outSizeMaxSkillIdDict[skillKey] then
		self._outSizeMaxSkillIdDict[skillKey] = true
		self._outSizeMaxSkillIdList = self._outSizeMaxSkillIdList or {}
		self._outSizeMaxSkillIdList[#self._outSizeMaxSkillIdList + 1] = skillKey
	end

	return true
end

function ArcadeSurvivorGameTriggerController:isTriggerChainActive(caster, trigger)
	local triggerDict = self._activeTriggerChainDict[caster]

	return triggerDict ~= nil and trigger ~= nil and triggerDict[trigger] == true
end

function ArcadeSurvivorGameTriggerController:beginTriggerChain(caster, trigger)
	if not caster or not trigger then
		return
	end

	local triggerDict = self._activeTriggerChainDict[caster]

	if not triggerDict then
		triggerDict = {}
		self._activeTriggerChainDict[caster] = triggerDict
	end

	triggerDict[trigger] = true
end

function ArcadeSurvivorGameTriggerController:endTriggerChain(caster, trigger)
	if not caster or not trigger then
		return
	end

	local triggerDict = self._activeTriggerChainDict[caster]

	if triggerDict then
		triggerDict[trigger] = nil
	end
end

function ArcadeSurvivorGameTriggerController:triggerMulti(triggerPoint, triggerPointParam, contextList)
	if not contextList or #contextList <= 0 then
		return
	end

	for _, context in ipairs(contextList) do
		self:trigger(triggerPoint, triggerPointParam, context)
	end
end

function ArcadeSurvivorGameTriggerController:trigger(triggerPoint, triggerPointParam, context)
	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	if not context then
		logError(string.format("ArcadeSurvivorGameTriggerController:trigger error, context is nil, triggerPoint:%s", tostring(triggerPoint)))

		return
	end

	local triggerPointWithParam = ArcadeSurvivorGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)
	local isContextMatch = context:checkTriggerPointWithParam(triggerPointWithParam)

	if not isContextMatch then
		logError(string.format("ArcadeSurvivorGameTriggerController:trigger error, context trigger point mismatch, triggerPointWithParam:%s, contextTriggerPointWithParam:%s", tostring(triggerPointWithParam), tostring(context:getTriggerPointWithParam())))

		return
	end

	self:_triggerSkill(context)
end

function ArcadeSurvivorGameTriggerController:_triggerSkill(context)
	local caster = context:getCaster()

	if not caster then
		return
	end

	if caster:getIsDead() and not context:getAllowDeadCaster() then
		return
	end

	local triggerPointWithParam = context:getTriggerPointWithParam()
	local triggerSkillList = caster:getTriggerSkillList(triggerPointWithParam)

	if not triggerSkillList or #triggerSkillList <= 0 then
		return
	end

	for _, skill in ipairs(triggerSkillList) do
		skill:tryTriggerCast(triggerPointWithParam, context)
	end
end

ArcadeSurvivorGameTriggerController.instance = ArcadeSurvivorGameTriggerController.New()

return ArcadeSurvivorGameTriggerController
