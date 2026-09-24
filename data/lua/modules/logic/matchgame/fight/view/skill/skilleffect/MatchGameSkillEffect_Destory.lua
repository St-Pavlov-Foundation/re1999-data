-- chunkname: @modules/logic/matchgame/fight/view/skill/skilleffect/MatchGameSkillEffect_Destory.lua

module("modules.logic.matchgame.fight.view.skill.skilleffect.MatchGameSkillEffect_Destory", package.seeall)

local MatchGameSkillEffect_Destory = class("MatchGameSkillEffect_Destory")

function MatchGameSkillEffect_Destory:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameSkillEffect_Destory:progressEffect_1001(effectCoData, targetInfoList, skillData)
	local canAddEnergy = effectCoData[2] and effectCoData[2] == 1
	local canAddFever = effectCoData[3] and effectCoData[3] == 1

	for index, targetInfo in ipairs(targetInfoList) do
		local targetElementItemMap = targetInfo.targetData

		self.sceneView:doSkillMatchAnim(targetElementItemMap, canAddFever, canAddEnergy, false)
	end
end

return MatchGameSkillEffect_Destory
