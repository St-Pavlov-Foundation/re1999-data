﻿-- chunkname: @modules/logic/fight/system/work/FightWorkPlay2Operate.lua

module("modules.logic.fight.system.work.FightWorkPlay2Operate", package.seeall)

local FightWorkPlay2Operate = class("FightWorkPlay2Operate", FightWorkItem)

function FightWorkPlay2Operate:onConstructor(isStart, isClothSkill)
	self.isStart = isStart
	self.isClothSkill = isClothSkill
end

function FightWorkPlay2Operate:onStart()
	FightViewPartVisible.set(true, true, true, false, false)

	local flow = self:com_registFlowSequence()

	flow:registFinishCallback(self.exitPlay, self)

	flow.CALLBACK_EVEN_IF_UNFINISHED = true

	if not self.isClothSkill then
		flow:registWork(FightWorkRefreshEnemyAiUseCard)
	end

	if FightDataHelper.stateMgr.isReplay then
		self:playWorkAndDone(flow)

		return
	end

	if FightDataHelper.fieldMgr:isDouQuQu() then
		self:playWorkAndDone(flow)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		self:playWorkAndDone(flow)

		return
	end

	if FightModel.instance:isFinish() then
		self:playWorkAndDone(flow)

		return
	end

	local guiding = FightMsgMgr.sendMsg(FightMsgId.CheckGuideBeforeOperate)

	if guiding then
		flow:registWork(FightWorkFunction, self.isGuiding, self)
		self:playWorkAndDone(flow)

		return
	end

	local curRoundId = FightModel.instance:getCurRoundId()

	flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.RoundStart, curRoundId))

	if FightDataHelper.stateMgr:getIsAuto() then
		flow:registWork(FightWorkRequestAutoFight)
	else
		flow:registWork(FightWorkCheckUseAiJiAoQte)
		flow:registWork(FightWorkClearAiJiAoQteTempData)
		flow:registWork(FightWorkCheckNewSeasonSubSkill)
		flow:registWork(FightWorkCheckNaNaBindContract)
		flow:registWork(FightWorkCheckLuXiHeroUpgrade)
		flow:registWork(FightWorkBLESelectCrystal)
	end

	flow:addWork(FightMsgMgr.sendMsg(FightMsgId.PlayCameraAnimWhenOperateStage))
	self:playWorkAndDone(flow)
end

function FightWorkPlay2Operate:isGuiding()
	FightDataHelper.stateMgr:setAutoState(false)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Operate)
	FightMsgMgr.sendMsg(FightMsgId.ContinueGuideBeforeOperate)
end

function FightWorkPlay2Operate:exitPlay()
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Operate)
end

function FightWorkPlay2Operate:gcFunc()
	SLFramework.UnityHelper.LuaGC()
end

return FightWorkPlay2Operate
