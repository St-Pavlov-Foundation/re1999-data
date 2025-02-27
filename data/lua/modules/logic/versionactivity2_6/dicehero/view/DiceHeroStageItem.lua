module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroStageItem", package.seeall)

slot0 = class("DiceHeroStageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._btnClick = gohelper.findChildButton(slot1, "")
	slot0.viewGo = gohelper.findChild(slot1, "#go_levelitem")
	slot0._gonormal = gohelper.findChild(slot0.viewGo, "#go_normal")
	slot0._golock = gohelper.findChild(slot0.viewGo, "#go_lock")
	slot0._gochallenge = gohelper.findChild(slot0.viewGo, "#go_challenge")
	slot0._gocompleted = gohelper.findChild(slot0.viewGo, "#go_completed")
	slot0._gopart = gohelper.findChild(slot1, "Part")
	slot0._gobossicon1 = gohelper.findChild(slot1, "Part/#go_BossIcon")
	slot0._gobossicon2 = gohelper.findChild(slot1, "Part/#go_BigBossIcon")
	slot0._lockAnim = gohelper.findChildAnim(slot0.viewGo, "#go_lock")
	slot0._completedAnim = gohelper.findChildAnim(slot0.viewGo, "#go_completed")
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._onClickStage, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, slot0._onInfoUpdate, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, slot0._onInfoUpdate, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.initData(slot0, slot1, slot2)
	slot0._co = slot1
	slot0.isInfinite = slot2

	gohelper.setActive(slot0._gobossicon1, slot1.enemyType == 1)
	gohelper.setActive(slot0._gobossicon2, slot1.enemyType == 2)
	slot0:_onInfoUpdate()
end

function slot0._onCloseViewFinish(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		return
	end

	slot0:_onInfoUpdate()

	if slot0._showUnlockAnim then
		gohelper.setActive(slot0._lockAnim, true)
		slot0._lockAnim:Play("unlock", 0, 0)
		TaskDispatcher.runDelay(slot0._hideLock, slot0, 2.4)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockHelper.instance:startBlock("DiceHeroStageItem_Unlock", 2)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockglass)
	end

	if slot0._showPassAnim then
		slot0._showPassAnim = false

		slot0._completedAnim:Play("completeglow", 0, 0)
	end
end

function slot0._hideLock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	gohelper.setActive(slot0._lockAnim, false)

	slot0._showUnlockAnim = false
end

function slot0._onInfoUpdate(slot0)
	slot1 = DiceHeroModel.instance:getGameInfo(slot0._co.chapter)

	if slot0._unLockStatu ~= nil and not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		if slot0._co.room - slot1.co.room ~= slot0._unLockStatu then
			if slot2 == 0 then
				slot0._showUnlockAnim = true
			elseif slot2 == -1 and slot0.isInfinite then
				slot0._showPassAnim = true
			end
		end

		return
	end

	gohelper.setActive(slot0._gonormal, not slot0.isInfinite and slot0._co.room >= slot1.co.room and slot1.allPass or false)
	gohelper.setActive(slot0._gocompleted, slot0.isInfinite and slot0._co.room >= slot1.co.room and slot1.allPass or false)
	gohelper.setActive(slot0._gochallenge, slot0._co.room == slot1.co.room and not slot1.allPass)
	gohelper.setActive(slot0._golock, slot1.co.room < slot0._co.room)
	gohelper.setActive(slot0._gopart, slot0._co.room <= slot1.co.room)

	slot0._unLockStatu = slot0._co.room - slot1.co.room
end

function slot0._onClickStage(slot0)
	if not slot0._co then
		return
	end

	if slot0._co.room < DiceHeroModel.instance:getGameInfo(slot0._co.chapter).co.room then
		if slot0.isInfinite then
			GameFacade.showToast(ToastEnum.DiceHeroPassLevel)

			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

		if slot0._co.type == DiceHeroEnum.LevelType.Story then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = slot0._co
			})
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(slot0._co.id, slot0._onEnterFight, slot0)
		end

		return
	elseif slot1.co.room < slot0._co.room then
		GameFacade.showToast(ToastEnum.DiceHeroLockLevel)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

	if slot0._co.type == DiceHeroEnum.LevelType.Story then
		if DiceHeroModel.instance:hasReward(slot0._co.chapter) or slot0._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
			slot0:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(slot0._co.id, slot0._co.chapter, slot0._onEnterStory, slot0)
		end
	elseif slot0._co.type == DiceHeroEnum.LevelType.Fight then
		if DiceHeroModel.instance:hasReward(slot0._co.chapter) then
			slot0:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(slot0._co.id, slot0._onEnterFight, slot0)
		end
	end
end

function slot0._onEnterStory(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:_onOpenDialog()
end

function slot0._onOpenDialog(slot0)
	if not slot0._co then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
		co = slot0._co
	})
end

function slot0._onEnterFight(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
end

function slot0.onDestroy(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0._hideLock, slot0)
end

return slot0
