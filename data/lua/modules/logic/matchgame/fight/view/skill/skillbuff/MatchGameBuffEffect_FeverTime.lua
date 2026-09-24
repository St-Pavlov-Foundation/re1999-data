-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_FeverTime.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_FeverTime", package.seeall)

local MatchGameBuffEffect_FeverTime = class("MatchGameBuffEffect_FeverTime")

function MatchGameBuffEffect_FeverTime:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_FeverTime:progressBuff_108(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.maxFeverTime = Mathf.Max(0, gameInfoMo.maxFeverTime + offsetTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverTime:removeBuff_108(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxFeverTime = gameInfoData.gameConfig.feverTime

	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverTime:progressBuff_109(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.maxFeverTime = Mathf.Max(0, gameInfoMo.maxFeverTime + offsetTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:refreshFeverUI()
end

function MatchGameBuffEffect_FeverTime:removeBuff_109(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxFeverTime = gameInfoData.gameConfig.feverTime

	self.sceneView:refreshFeverUI()
end

return MatchGameBuffEffect_FeverTime
