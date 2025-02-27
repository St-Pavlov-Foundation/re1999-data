module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroMainView", package.seeall)

slot0 = class("DiceHeroMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._gotaskred = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._taskAnimator = gohelper.findChildAnim(slot0.viewGO, "#btn_Task/ani")

	for slot4 = 1, 5 do
		slot0["_btnstage" .. slot4] = gohelper.findChildButton(slot0.viewGO, "#btn_stage" .. slot4)
		slot0["_lockAnim" .. slot4] = gohelper.findChildAnim(slot0.viewGO, "#btn_stage" .. slot4 .. "/lock")
	end

	slot0._lockAnim5 = gohelper.findChildAnim(slot0.viewGO, "#btn_stage5")
end

function slot0.addEvents(slot0)
	slot4 = slot0

	slot0._btnTask:AddClickListener(slot0._onClickTask, slot4)

	for slot4 = 1, 5 do
		slot0["_btnstage" .. slot4]:AddClickListener(slot0._onClickStage, slot0, slot4)
	end

	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, slot0._onInfoUpdate, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTask:RemoveClickListener()

	for slot4 = 1, 5 do
		slot0["_btnstage" .. slot4]:RemoveClickListener()
	end

	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, slot0._onInfoUpdate, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshTask()

	DiceHeroModel.instance.isUnlockNewChapter = false

	RedDotController.instance:addRedDot(slot0._gotaskred, RedDotEnum.DotNode.V2a6DiceHero)
	slot0:_onInfoUpdate()
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6DiceHero, 0) then
		slot0._taskAnimator:Play("loop", 0, 0)
	else
		slot0._taskAnimator:Play("idle", 0, 0)
	end
end

function slot0._onClickTask(slot0)
	ViewMgr.instance:openView(ViewName.DiceHeroTaskView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.DiceHeroLevelView and DiceHeroModel.instance.isUnlockNewChapter then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockchapter)

		DiceHeroModel.instance.isUnlockNewChapter = false

		slot0:_onInfoUpdate()
		UIBlockHelper.instance:startBlock("DiceHeroMainView_PlayUnlock", 1.5)

		if #DiceHeroModel.instance.unlockChapterIds == 5 then
			slot0._lockAnim5:Play("open", 0, 0)
		else
			gohelper.setActive(slot0["_lockAnim" .. slot2], true)
			slot0["_lockAnim" .. slot2]:Play("unlock", 0, 0)
		end

		TaskDispatcher.runDelay(slot0._delayRefreshAnim, slot0, 1.5)
	end
end

function slot0._delayRefreshAnim(slot0)
	if #DiceHeroModel.instance.unlockChapterIds == 5 then
		slot0._lockAnim5:Play("loop", 0, 0)
	else
		gohelper.setActive(slot0["_lockAnim" .. slot1], false)
	end
end

function slot0._onInfoUpdate(slot0)
	if DiceHeroModel.instance.isUnlockNewChapter then
		return
	end

	slot1 = DiceHeroModel.instance.unlockChapterIds

	for slot5 = 1, 5 do
		slot6 = DiceHeroModel.instance:getGameInfo(slot5)
		slot7 = slot0["_btnstage" .. slot5].gameObject
		slot11 = gohelper.findChildTextMesh(slot7, "Name/#txt_name") or gohelper.findChildTextMesh(slot7, "#txt_name")

		gohelper.setActive(gohelper.findChild(slot7, "normal"), slot1[slot5] and slot6.allPass)
		gohelper.setActive(gohelper.findChild(slot7, "lock"), not slot1[slot5])
		gohelper.setActive(gohelper.findChild(slot7, "Name"), slot1[slot5])
		gohelper.setActive(gohelper.findChild(slot7, "challenge"), slot1[slot5] and not slot6.allPass)

		if slot5 == 5 then
			gohelper.setActive(slot7, slot1[slot5])
		end

		if DiceHeroConfig.instance:getLevelCo(slot5, 1) and slot11 then
			slot11.text = GameUtil.setFirstStrSize(slot13.chapterName, 70)
		end
	end
end

function slot0._onClickStage(slot0, slot1)
	if not DiceHeroModel.instance.unlockChapterIds[slot1] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return
	end

	slot0._enterChapterId = slot1

	slot0:_enterChapter()
end

function slot0._enterChapter(slot0)
	if not slot0._enterChapterId then
		return
	end

	if not DiceHeroConfig.instance:getLevelCo(slot0._enterChapterId, 1) then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = slot0._enterChapterId,
		isInfinite = slot1.mode == 2
	})
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delayRefreshAnim, slot0)
end

return slot0
