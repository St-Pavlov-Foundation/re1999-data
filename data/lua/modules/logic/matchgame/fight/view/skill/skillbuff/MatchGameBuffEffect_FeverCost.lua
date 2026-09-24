-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_FeverCost.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_FeverCost", package.seeall)

local MatchGameBuffEffect_FeverCost = class("MatchGameBuffEffect_FeverCost")

function MatchGameBuffEffect_FeverCost:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_FeverCost:progressBuff_110(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.maxFeverNum = Mathf.Max(0, gameInfoMo.maxFeverNum + offsetTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverCost:removeBuff_110(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxFeverNum = gameInfoData.gameConfig.feverCost

	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverCost:progressBuff_111(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.maxFeverNum = Mathf.Max(0, gameInfoMo.maxFeverNum + offsetTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverCost:removeBuff_111(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxFeverNum = gameInfoData.gameConfig.feverCost

	self.sceneView:refreshFeverUI()
end

return MatchGameBuffEffect_FeverCost
