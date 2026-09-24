-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_GemProbability.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_GemProbability", package.seeall)

local MatchGameBuffEffect_GemProbability = class("MatchGameBuffEffect_GemProbability")

function MatchGameBuffEffect_GemProbability:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_GemProbability:progressBuff_104(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local elementId = buffEffectData[2]
	local dropRate = buffEffectData[3]

	MatchGameFightModel.instance:setElementDropRateMap(elementId, dropRate)

	local gameInfoMo = self.sceneView:getGameInfoMo()

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
end

function MatchGameBuffEffect_GemProbability:removeBuff_104(buffEffectData, targetObj)
	local elementId = buffEffectData[2]

	MatchGameFightModel.instance:setElementDropRateMap(elementId, nil)
end

function MatchGameBuffEffect_GemProbability:getCurRandomElementIdList(careerNum)
	local elementItemMap = self.sceneView:getElementItemMap()
	local elementCareerMap = {}
	local allElementIdList = {}

	for posXIndex, itemMap in pairs(elementItemMap) do
		for posYIndex, elementItem in pairs(itemMap) do
			if elementItem and elementItem.comp.itemType == MatchGameFightEnum.ElementItemType.Bead and not elementCareerMap[elementItem.comp.itemParam] then
				elementCareerMap[elementItem.comp.itemParam] = true

				table.insert(allElementIdList, elementItem.comp.elementId)
			end
		end
	end

	local elementIdList = {}

	while careerNum > #elementIdList and #allElementIdList > 0 do
		local randomIndex = math.random(1, #allElementIdList)

		table.insert(elementIdList, allElementIdList[randomIndex])
		table.remove(allElementIdList, randomIndex)
	end

	return elementIdList
end

function MatchGameBuffEffect_GemProbability:progressBuff_105(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local dropRate = buffEffectData[3]
	local elementIdList = self:getCurRandomElementIdList(buffEffectData[2])

	for _, elementId in ipairs(elementIdList) do
		MatchGameFightModel.instance:setElementDropRateMap(elementId, dropRate)
	end

	skillBuffMo.effectData.elementIdList = elementIdList

	local gameInfoMo = self.sceneView:getGameInfoMo()

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
end

function MatchGameBuffEffect_GemProbability:removeBuff_105(buffEffectData, targetObj, skillBuffMo)
	local elementIdList = skillBuffMo and skillBuffMo.effectData and skillBuffMo.effectData.elementIdList

	if elementIdList then
		for _, elementId in ipairs(elementIdList) do
			MatchGameFightModel.instance:setElementDropRateMap(elementId, nil)
		end

		skillBuffMo.effectData.elementIdList = nil
	end
end

return MatchGameBuffEffect_GemProbability
