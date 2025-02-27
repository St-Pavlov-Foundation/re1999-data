module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepWaitGameStart", package.seeall)

slot0 = class("XugoujiGameStepWaitGameStart", XugoujiGameStepBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.start(slot0)
	XugoujiController.instance:registerCallback(XugoujiEvent.OpenGameViewFinish, slot0.onOpenGameViewFinish, slot0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)
end

function slot0.onOpenGameViewFinish(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, slot0.onOpenGameViewFinish, slot0)
	slot0:_showGameTargetTips()
end

function slot0._showGameTargetTips(slot0)
	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(slot0._autoCloseTargetTips, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, 4).value2))
		TaskDispatcher.runDelay(slot0._showSkillTips, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, 5).value2))
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowTargetTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideTargetTips, slot0._showTargetTipsDone, slot0)
end

function slot0._autoCloseTargetTips(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideTargetTips)
end

function slot0._showTargetTipsDone(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, slot0._showTargetTipsDone, slot0)

	if slot0._showingSkill then
		return
	else
		TaskDispatcher.cancelTask(slot0._autoCloseTargetTips, slot0)
		TaskDispatcher.cancelTask(slot0._showSkillTips, slot0)
		slot0:_showSkillTips()
	end
end

function slot0._showSkillTips(slot0)
	slot0._showingSkill = true

	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(slot0.finish, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, 7).value2))
		TaskDispatcher.runDelay(slot0._autoCloseSkillTips, slot0, tonumber(Activity188Config.instance:getConstCfg(uv0, 6).value2))
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowSkillTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideSkillTips, slot0._showSkillTipsDone, slot0)
end

function slot0._autoCloseSkillTips(slot0)
	slot0.autoSkillTipsClosed = true

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
end

function slot0._showSkillTipsDone(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, slot0._showSkillTipsDone, slot0)

	if slot0._finish then
		return
	else
		TaskDispatcher.cancelTask(slot0.finish, slot0)
		TaskDispatcher.cancelTask(slot0._autoCloseSkillTips, slot0)
		slot0:finish()
	end
end

function slot0.finish(slot0)
	slot0._finish = true

	if not slot0.autoSkillTipsClosed then
		XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, slot0._showSkillTipsDone, slot0)
		TaskDispatcher.cancelTask(slot0._autoCloseSkillTips, slot0)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
	end

	XugoujiGameStepBase.finish(slot0)
end

function slot0.dispose(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, slot0.onOpenGameViewFinish, slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, slot0._showSkillTipsDone, slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, slot0._showTargetTipsDone, slot0)
	TaskDispatcher.cancelTask(slot0._autoCloseTargetTips, slot0)
	TaskDispatcher.cancelTask(slot0._showSkillTips, slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	TaskDispatcher.cancelTask(slot0._autoCloseSkillTips, slot0)
	XugoujiGameStepBase.dispose(slot0)
end

return slot0
