-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_AttackRate.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_AttackRate", package.seeall)

local MatchGameBuffEffect_AttackRate = class("MatchGameBuffEffect_AttackRate")

function MatchGameBuffEffect_AttackRate:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_AttackRate:progressBuff_112(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local offsetRate = (buffEffectData[2] or 0) / 1000

	for index, targetInfo in ipairs(targetInfoList) do
		local selectFightMoMap = targetInfo.targetData

		for _, fightMo in pairs(selectFightMoMap) do
			if fightMo and fightMo.attackRate then
				fightMo:updateFightInfo({
					attackRate = fightMo.attackRate + offsetRate
				})
				MatchGameSkillBuffHandler.instance:attachBuffToTarget(fightMo, skillBuffMo)
			end
		end
	end
end

function MatchGameBuffEffect_AttackRate:removeBuff_112(buffEffectData, targetObj)
	local offsetRate = (buffEffectData[2] or 0) / 1000

	targetObj:updateFightInfo({
		attackRate = targetObj.attackRate - offsetRate
	})
end

return MatchGameBuffEffect_AttackRate
