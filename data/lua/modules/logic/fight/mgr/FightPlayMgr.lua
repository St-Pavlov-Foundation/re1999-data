﻿-- chunkname: @modules/logic/fight/mgr/FightPlayMgr.lua

module("modules.logic.fight.mgr.FightPlayMgr", package.seeall)

local FightPlayMgr = class("FightPlayMgr", FightBaseClass)

function FightPlayMgr:onConstructor()
	self.workComp = self:addComponent(FightWorkComponent)

	self:com_registMsg(FightMsgId.ForceReleasePlayFlow, self.onForceReleasePlayFlow)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
end

function FightPlayMgr:onForceReleasePlayFlow()
	self.workComp:disposeAllWork()
end

function FightPlayMgr:onStageChanged(curStage, preStage)
	if curStage == FightStageMgr.StageType.Play then
		self.workComp:disposeAllWork()
	end
end

function FightPlayMgr:playStart()
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayStart)
	flow:registWork(FightWorkPlay2Operate, true)
	flow:start()
end

function FightPlayMgr:playShow()
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayShow)
	flow:registWork(FightWorkPlay2Operate)
	flow:start()
end

function FightPlayMgr:playCloth()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.ClothSkill)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayCloth)
	flow:registWork(FightWorkPlay2Operate, false, true)
	flow:start()
end

function FightPlayMgr:playEnd()
	self.workComp:disposeAllWork()

	FightDataHelper.stateMgr.isFinish = true

	if FightSystem.instance.restarting then
		return
	end

	if FightRestartHelper.tryRestart() then
		return
	end

	ViewMgr.instance:closeView(ViewName.FightQuitTipView)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	FightGameMgr.restartMgr:killComponent(FightFlowComponent)
	FightDataMgr.instance.stateMgr:setPlayingEnd(true)
	self:_PlayEnd()
end

function FightPlayMgr:_PlayEnd()
	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayEnd)
	flow:registFinishCallback(self.onEndFinish, self)
	flow:start()
end

function FightPlayMgr:onEndFinish()
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function FightPlayMgr:playReconnect()
	FightController.instance:dispatchEvent(FightEvent.OnFightReconnect)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		local flow = self.workComp:registWork(FightWorkFlowSequence)

		flow:registWork(FightWorkPlayReconnect)
		flow:registWork(FightWorkPlay2Operate, true)
		flow:start()
	end
end

function FightPlayMgr:onDestructor()
	return
end

return FightPlayMgr
