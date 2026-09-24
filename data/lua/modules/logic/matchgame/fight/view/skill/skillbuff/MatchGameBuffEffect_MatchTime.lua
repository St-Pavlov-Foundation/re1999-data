-- chunkname: @modules/logic/matchgame/fight/view/skill/skillbuff/MatchGameBuffEffect_MatchTime.lua

module("modules.logic.matchgame.fight.view.skill.skillbuff.MatchGameBuffEffect_MatchTime", package.seeall)

local MatchGameBuffEffect_MatchTime = class("MatchGameBuffEffect_MatchTime")

function MatchGameBuffEffect_MatchTime:init(viewContent)
	self.fightView = viewContent.fightView
	self.sceneView = viewContent.sceneView
	self.skillView = viewContent.skillView
end

function MatchGameBuffEffect_MatchTime:progressBuff_106(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Hero or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.curRoundTime = Mathf.Max(gameInfoMo.curRoundTime + offsetTime, 0)
	gameInfoMo.maxRoundTime = Mathf.Max(gameInfoMo.maxRoundTime, gameInfoMo.curRoundTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:skillChangeRoundTime(gameInfoMo.curRoundTime)
end

function MatchGameBuffEffect_MatchTime:removeBuff_106(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxRoundTime = gameInfoData.gameConfig.matchTime

	self.sceneView:refreshRoundTime(gameInfoMo.curRoundTime)
end

function MatchGameBuffEffect_MatchTime:progressBuff_107(buffEffectData, targetInfoList, skillData, skillBuffMo)
	local gameInfoMo = self.sceneView:getGameInfoMo()

	if skillData and skillData.skillUserMo.skillUserType ~= MatchGameFightEnum.SkillUserType.Enemy or not gameInfoMo then
		return
	end

	local offsetTime = buffEffectData[2] or 0

	gameInfoMo.maxRoundTime = Mathf.Max(0, gameInfoMo.maxRoundTime + offsetTime)

	MatchGameSkillBuffHandler.instance:attachBuffToTarget(gameInfoMo, skillBuffMo)
	self.sceneView:refreshRoundTime()
end

function MatchGameBuffEffect_MatchTime:removeBuff_107(buffEffectData, targetObj)
	local gameInfoMo = self.sceneView:getGameInfoMo()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()

	gameInfoMo.maxRoundTime = gameInfoData.gameConfig.matchTime

	self.sceneView:refreshRoundTime()
end

return MatchGameBuffEffect_MatchTime
